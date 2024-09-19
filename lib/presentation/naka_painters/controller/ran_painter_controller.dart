import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constant/dialogs.dart';
import '../../../core/style/app_color.dart';
import '../../../core/util/image_util.dart';
import '../../../core/util/log_util.dart';
import '../../auth/controller/auth_controller.dart';
import '../../common_models/common_type_models.dart';
import '../../common_models/type_of_customer_model.dart';
import '../../home/controller/home_controller.dart';
import '../../home/home_page.dart';
import '../../common_models/common_model.dart';
import '../model/ran_painter_model.dart';
import '../repo/ran_painter_repo.dart';

class RanPainterController extends GetxController {
  Rx<TextEditingController> painterName = TextEditingController().obs;
  Rx<TextEditingController> painterPhone = TextEditingController().obs;
  Rx<TextEditingController> geoLocation = TextEditingController().obs;
  Rx<TextEditingController> giveaways = TextEditingController().obs;
  Rx<TextEditingController> remarks = TextEditingController().obs;
  RxList<CommonTypeModel> typeOfPaintersList = RxList.empty();
  RxList<RanPainterModel> ranPainterModel = RxList.empty();
  Rx<CommonTypeModel?> typeOfPainterModifier = Rx(null);
  RanPainterModel? ranPainter;
  var isLoading = false.obs;
  var isEditLoading = false.obs;
  var isLocationFetched = false.obs;
  Rx<RanPainterModel?> ranPainterModifier = Rx(null);
  RxList<Uint8List> selectedImages = RxList.empty();
  RxList<ImageModel> uploadedImages = RxList.empty();
  List<int> deletedId = [];
  List<ImageModel> imageList = [];
  List<Customers> customersList = [];
  List<ImageModel> deletedImageList = RxList.empty();
  final Rxn<Position?> currentPosition = Rxn<Position>(null);
  RxString sampling = RxString('No');
  RxString engagement = RxString('No');
  RxString videoShown = RxString('No');

  static RanPainterController get instance => Get.find<RanPainterController>();

  @override
  void onInit() {
    // TODO: implement onInit
    getTypeOfPainter();
    super.onInit();
  }

  void clear() {
    painterName.value.text = '';
    painterPhone.value.text = '';
    geoLocation.value.text = '';
    giveaways.value.text = '';
    remarks.value.text = '';
    sampling = RxString('No');
    engagement = RxString('No');
    videoShown = RxString('No');
    getCurrentPosition();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    painterName.value.dispose();
    painterPhone.value.dispose();
    geoLocation.value.dispose();
    giveaways.value.dispose();
    remarks.value.dispose();
  }

  Future<String> uploadImage(
      int siteId, String imageKey, String imageData) async {
    return await RanOutletRepo.uploadPainterImage(
        imageData, imageKey, AuthController.instance.user!, siteId);
  }

  void insertPainter() async {
    isLoading(true);
    try {
      ImageModel dummy;
      ranPainter = RanPainterModel(
        dbType: "insertNakaPainter",
        painterName: painterName.value.text,
        painterPhone: (painterPhone.value.text),
        // mapLink: ,
        giveaways: giveaways.value.text,
        companyId: AuthController.instance.user?.companyId,
        geolocation: geoLocation.value.text,
        latitude: currentPosition.value?.latitude.toString(),
        longitude: currentPosition.value?.longitude.toString(),
        remarks: remarks.value.text,
        // createdBy: AuthController.instance.user!.name ?? "admin",
        // createdAt: DateTime.now().toString(),
        engagement: engagement.value == "Yes" ? 1 : 0,
        videoShown: videoShown.value == "Yes" ? 1 : 0,
        // updatedBy: '',
        // updatedAt: '',
      );
      ranPainter?.painterId = await RanOutletRepo.insertRanPainter(ranPainter!);
      if (ranPainter?.painterId != null) {
        for (int i = 0; i < selectedImages.length; i++) {
          String imageUrl = await uploadImage(ranPainter!.painterId!,
              'naka', Utility.base64String(selectedImages[i]));
          dummy = ImageModel(
              imageId: i, path: imageUrl, siteId: ranPainter!.painterId);
          imageList.add(dummy);
        }
      }
      ranPainter?.images = imageList;
      HomePageController.instance.updatingRan(ranPainter!);
      HomePageController.instance.listOfRanPainters.insert(0,ranPainter!);
      isLoading(false);
      Get.offAllNamed(HomePage.routeName);
      HomePageController.instance.lengthOfSites.value =
          HomePageController.instance.lengthOfSites.value + 1;
      Get.snackbar('Congrats!', 'Naka painter is inserted.',
          backgroundColor: AppColors.blue, colorText: AppColors.white);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "please try again");
    }
  }

  void updatePainter() async {
    isLoading(true);
    try {
      ImageModel dummy;
      for (int i = 0; i < uploadedImages.length; i++) {
        imageList.add(uploadedImages[i]);
      }
      ranPainter = RanPainterModel(
        dbType: "updateNakaPainter",
        painterId: ranPainter!.painterId,
        companyId: AuthController.instance.user?.companyId,
        painterName: painterName.value.text,
        painterPhone: (painterPhone.value.text),
        painterType: typeOfPainterModifier.value!.commonTypeValue,
        // mapLink: ,
        giveaways: giveaways.value.text,
        geolocation: geoLocation.value.text,
        latitude: currentPosition.value?.latitude == null
            ? ranPainter?.latitude
            : currentPosition.value?.latitude.toString(),
        longitude: currentPosition.value?.longitude == null
            ? ranPainter?.longitude
            : currentPosition.value?.longitude.toString(),
        remarks: remarks.value.text,
        engagement: engagement.value == "Yes" ? 1 : 0,
        videoShown: videoShown.value == "Yes" ? 1 : 0,
        // createdBy: ranPainter?.createdBy ?? "",
        // createdAt: ranPainter?.createdAt ?? DateTime.now().toString(),
        // updatedBy: AuthController.instance.user!.name ?? "",
        // updatedAt: DateTime.now().toString(),
        images: deletedImageList,
      );
      await RanOutletRepo.updateRanPainter(ranPainter!).then((value) {
        HomePageController.instance.listOfRanPainters
            .removeWhere((col) => col.painterId == ranPainter!.painterId);
      });
      for (int i = 0; i < selectedImages.length; i++) {
        String imageUrl = await uploadImage(ranPainter!.painterId!,
            'naka', Utility.base64String(selectedImages[i]));
        dummy = ImageModel(
            imageId: i, path: imageUrl, siteId: ranPainter!.painterId);
        imageList.add(dummy);
      }
      ranPainter?.images = imageList;
      LogUtil.debug(ranPainter?.toJson());
      HomePageController.instance.updatingRan(ranPainter!);
      HomePageController.instance.listOfRanPainters.insert(0,ranPainter!);
      isLoading(false);
      Dialogs.showSnackBar(Get.context, "Naka painter updated");

      Get.back();
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "$e");
    }
  }

  void editPainter() async {
    isEditLoading(true);
    ranPainter = Get.arguments;
    LogUtil.debug(ranPainter?.toJson());
    try {
      if (ranPainter != null) {
        painterName.value.text = ranPainter!.painterName ?? '';
        painterPhone.value.text = ranPainter!.painterPhone.toString();
        giveaways.value.text = ranPainter!.giveaways ?? '';
        geoLocation.value.text = ranPainter!.geolocation ?? '';
        engagement.value = ranPainter?.engagement == 1 ? "Yes" : "No";
        videoShown.value = ranPainter?.videoShown == 1 ? "Yes" : "No";
        remarks.value.text = ranPainter?.remarks ?? '';
        typeOfPainterModifier.value = typeOfPaintersList.firstWhereOrNull(
                (element) => element.commonTypeValue == ranPainter?.painterType);
        setSiteTypeValue(typeOfPainterModifier.value);
        selectedImages.clear();
        uploadedImages.clear();
        deletedId.clear();
        deletedImageList.clear();
        if (ranPainter!.images!.isNotEmpty) {
          for (int i = 0; i < ranPainter!.images!.length; i++) {
            uploadedImages.add(ranPainter!.images![i]);
          }
        }

        isEditLoading(false);
      }
    } catch (e) {
      isEditLoading(false);
      LogUtil.error("error : $e");
      Get.snackbar('Error', "$e");
    }
  }

  getTypeOfPainter() async {
    HomePageController.instance.searchPainters('');
    typeOfPaintersList.clear();
    typeOfPaintersList.addAll(await RanOutletRepo.getTypeOfPainterTypeData());
  }

  Future<void> pickPic(ImageSource source) async {
    ImagePicker()
        .pickImage(
      source: source,
      imageQuality: 20,
      preferredCameraDevice: CameraDevice.front,
    )
        .then(
      (imgFile) async {
        if (imgFile != null) {
          selectedImages.add(await imgFile.readAsBytes());
        }
      },
    );
  }

  removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void setSiteTypeValue(CommonTypeModel? siteType) {
    typeOfPainterModifier.value = siteType;
  }

  removeUploadedImage(int index) {
    deletedImageList.add(uploadedImages[index]);
    LogUtil.debug(deletedImageList.length);
    deletedId.add(index);
    uploadedImages.removeAt(index);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition.value!.latitude, currentPosition.value!.longitude)
        .then((List<Placemark> placeMark) {
      Placemark place = placeMark[0];
      geoLocation.value.text =
          '${place.street}, ${place.subLocality}, ${place.locality!}, ${place.postalCode}';
      LogUtil.debug(geoLocation.value.text);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Dialogs.showSnackBar(Get.context,
          'Location services are disabled. Please enable the services');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Dialogs.showSnackBar(Get.context, 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Dialogs.showSnackBar(Get.context,
          'Location permissions are permanently denied, we cannot request permissions.');
      isLoading(false);
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    isLocationFetched.value = true;
    LogUtil.debug(isLocationFetched.value);
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high, distanceFilter: 100))
        .then((Position position) {
      currentPosition.value = position;
      LogUtil.debug(currentPosition.value);
      _getAddressFromLatLng(currentPosition.value!);
      isLocationFetched.value = false;
    }).catchError((e) {
      debugPrint(e);
      isLocationFetched.value = false;
    });
  }
}
