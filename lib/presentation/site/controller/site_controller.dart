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
import '../../home/controller/home_controller.dart';
import '../../home/home_page.dart';
import '../model/common_model.dart';
import '../model/site_model.dart';
import '../repo/site_repo.dart';

class SitesController extends GetxController {
  Rx<TextEditingController> contractorName = TextEditingController().obs;
  Rx<TextEditingController> contractorPhone = TextEditingController().obs;
  Rx<TextEditingController> siteAddress = TextEditingController().obs;
  Rx<TextEditingController> contractorAddress = TextEditingController().obs;
  Rx<TextEditingController> remarks = TextEditingController().obs;
  Rx<TextEditingController> geoLocation = TextEditingController().obs;
  Rx<TextEditingController> giveaways = TextEditingController().obs;
  RxList<CityModel> citiesList = RxList.empty();
  RxList<SiteTypeModel> typeOfSitesList = RxList.empty();
  RxList<SiteModel> sitesList = RxList.empty();
  RxList<Painters> selectedPaintersList = RxList.empty();
  RxList<Painters> uploadedPaintersList = RxList.empty();
  SiteModel? site;
  var isLoading = false.obs;
  var isEditLoading = false.obs;
  var isLocationFetched = false.obs;
  Rx<CityModel?> cityModifier = Rx(null);
  Rx<SiteTypeModel?> typeOfSiteModifier = Rx(null);
  Rx<SiteModel?> siteModifier = Rx(null);
  RxList<Uint8List> selectedImages = RxList.empty();
  RxList<ImageModel> uploadedImages = RxList.empty();
  List<int> deletedId = [];
  List<ImageModel> imageList = [];
  List<Painters> paintersList = [];
  List<ImageModel> deletedImageList = RxList.empty();
  final Rxn<Position?> currentPosition = Rxn<Position>(null);

  static SitesController get instance => Get.find<SitesController>();

  @override
  void onInit() {
    // TODO: implement onInit
    getCities();
    getTypeOfSites();
    super.onInit();
  }

  void clear() {
    contractorName.value.text = '';
    contractorPhone.value.text = '';
    contractorAddress.value.text = '';
    siteAddress.value.text = '';
    remarks.value.text = '';
    geoLocation.value.text = '';
    giveaways.value.text = '';
    cityModifier.value = null;
    typeOfSiteModifier.value = null;
    getCurrentPosition();
    LogUtil.debug('running');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contractorName.value.dispose();
    contractorPhone.value.dispose();
    contractorAddress.value.dispose();
    siteAddress.value.dispose();
    remarks.value.dispose();
    geoLocation.value.dispose();
    giveaways.value.dispose();
  }

  Future<String> uploadImage(
      int siteId, String imageKey, String imageData) async {
    return await SiteRepo.uploadSiteImage(
        imageData, imageKey, AuthController.instance.user!, siteId);
  }

  void insertSite() async {
    isLoading(true);
    try {
      ImageModel dummy;
      site = SiteModel(
        dbType: "insertSite",
        companyId: AuthController.instance.user?.companyId,
        contractorName: contractorName.value.text,
        contractorPhone: (contractorPhone.value.text),
        contractorAddress: contractorAddress.value.text,
        siteCityId: cityModifier.value?.cityId ?? 1,
        siteAddress: siteAddress.value.text,
        siteType: typeOfSiteModifier.value?.siteTypeValue,
        // mapLink: ,
        remarks: remarks.value.text,
        geoLocation: geoLocation.value.text,
        lat: currentPosition.value?.latitude.toString(),
        long: currentPosition.value?.longitude.toString(),
        giveAWays: giveaways.value.text,
        painters: selectedPaintersList,
        createdBy: AuthController.instance.user!.name ?? "admin",
        createdAt: DateTime.now().toString(),
        updatedBy: '',
        updatedAt: '',
        cityName: cityModifier.value?.cityName,
      );
      LogUtil.debug(site?.toJson());
      site?.siteId = await SiteRepo.insertSite(site!);
      if (site?.siteId != null) {
        for (int i = 0; i < selectedImages.length; i++) {
          String imageUrl = await uploadImage(
              site!.siteId!, 'site', Utility.base64String(selectedImages[i]));
          dummy = ImageModel(imageId: i, path: imageUrl, siteId: site!.siteId);
          imageList.add(dummy);
        }
      }
      site?.images = imageList;
      HomePageController.instance.listOfSites.add(site!);
      isLoading(false);
      Get.offAllNamed(HomePage.routeName);
      HomePageController.instance.lengthOfListOfSites.value =
          HomePageController.instance.lengthOfListOfSites.value + 1;
      Get.snackbar('Congrats!', 'Site is inserted.',
          backgroundColor: AppColors.blue, colorText: AppColors.white);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "please try again");
    }
  }

  void updateSite() async {
    isLoading(true);
    try {
      LogUtil.debug(currentPosition.value!.latitude);
      ImageModel dummy;
      for (int i = 0; i < uploadedImages.length; i++) {
        imageList.add(uploadedImages[i]);
      }
      for (int i = 0; i < uploadedPaintersList.length; i++) {
        paintersList.add(uploadedPaintersList[i]);
      }
      site = SiteModel(
        dbType: "updateSite",
        siteId: site!.siteId,
        companyId: AuthController.instance.user?.companyId,
        contractorName: contractorName.value.text,
        contractorAddress: contractorAddress.value.text,
        contractorPhone: (contractorPhone.value.text),
        siteCityId: cityModifier.value?.cityId ?? 1,
        siteAddress: siteAddress.value.text,
        siteType: typeOfSiteModifier.value?.siteTypeValue,
        // mapLink: ,
        remarks: remarks.value.text,
        geoLocation: geoLocation.value.text,
        lat: currentPosition.value?.latitude != null ? currentPosition.value?.latitude.toString() : site?.lat,
        long: currentPosition.value?.longitude != null ? currentPosition.value?.longitude.toString() : site?.long,
        giveAWays: giveaways.value.text,
        painters: uploadedPaintersList,
        createdBy: site?.createdBy ?? "admin",
        createdAt: site?.createdAt ?? DateTime.now().toString(),
        updatedBy: AuthController.instance.user!.name ?? "admin",
        updatedAt: DateTime.now().toString(),
        cityName: cityModifier.value?.cityName,
        images: deletedImageList,
      );
      await SiteRepo.updateSite(site!).then((value) {
        HomePageController.instance.listOfSites
            .removeWhere((col) => col.siteId == site!.siteId);
      });
      for (int i = 0; i < selectedPaintersList.length; i++) {
        paintersList.add(selectedPaintersList[i]);
      }
      for (int i = 0; i < selectedImages.length; i++) {
        String imageUrl = await uploadImage(
            site!.siteId!, 'site', Utility.base64String(selectedImages[i]));
        dummy = ImageModel(imageId: i, path: imageUrl, siteId: site!.siteId);
        imageList.add(dummy);
      }
      site?.painters = paintersList;
      site?.images = imageList;
      LogUtil.debug(site?.toJson());
      HomePageController.instance.listOfSites.add(site!);
      isLoading(false);
      Dialogs.showSnackBar(Get.context, "Site updated");

      Get.back();
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "$e");
    }
  }

  void editSite() async {
    isEditLoading(true);
    site = Get.arguments;
    try {
      if (site != null) {
        contractorName.value.text = site!.contractorName ?? '';
        contractorAddress.value.text = site!.contractorAddress ?? '';
        contractorPhone.value.text = site!.contractorPhone.toString();
        cityModifier.value = citiesList
            .firstWhereOrNull((element) => element.cityName == site!.cityName);
        typeOfSiteModifier.value = typeOfSitesList.firstWhereOrNull(
            (element) => element.siteTypeValue == site!.siteType);
        setCityValue(cityModifier.value);
        setSiteTypeValue(typeOfSiteModifier.value);
        siteAddress.value.text = site!.siteAddress ?? '';
        remarks.value.text = site!.remarks ?? '';
        giveaways.value.text = site!.giveAWays ?? '';
        selectedPaintersList.clear();
        uploadedPaintersList.clear();
        selectedImages.clear();
        uploadedImages.clear();
        deletedId.clear();
        deletedImageList.clear();
        LogUtil.debug(site?.toJson());
        if (site!.images!.isNotEmpty) {
          for (int i = 0; i < site!.images!.length; i++) {
            uploadedImages.add(site!.images![i]);
          }
        }
        if (site!.painters!.isNotEmpty) {
          LogUtil.debug(site!.painters!.length);
          for (int i = 0; i < site!.painters!.length; i++) {
            uploadedPaintersList.add(site!.painters![i]);
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

  getCities() async {
    citiesList.clear();
    citiesList.addAll(HomePageController.instance.citiesList);
  }

  getTypeOfSites() async {
    typeOfSitesList.clear();
    typeOfSitesList.addAll(await SiteRepo.getTypeOfSitesData());
  }

  void setCityValue(CityModel? city) {
    cityModifier.value = city;
  }

  void setSiteTypeValue(SiteTypeModel? siteType) {
    typeOfSiteModifier.value = siteType;
  }

  void setCollegeValue(SiteModel? site) {
    siteModifier.value = site;
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
