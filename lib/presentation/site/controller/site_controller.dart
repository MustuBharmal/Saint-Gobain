import 'dart:typed_data';

import 'package:flutter/material.dart';
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
  Rx<TextEditingController> giveaways = TextEditingController().obs;
  RxList<CityModel> citiesList = RxList.empty();
  RxList<SiteTypeModel> typeOfSitesList = RxList.empty();
  RxList<SiteModel> sitesList = RxList.empty();
  RxList<Painters> paintersList = RxList.empty();
  SiteModel? site;
  var isLoading = false.obs;
  var isEditLoading = false.obs;
  Rx<CityModel?> cityModifier = Rx(null);
  Rx<SiteTypeModel?> typeOfSiteModifier = Rx(null);
  Rx<SiteModel?> siteModifier = Rx(null);
  RxList<Uint8List> selectedImages = RxList.empty();
  RxList<ImageModel> uploadedImages = RxList.empty();
  List<int> deletedId = [];
  List<ImageModel> imageList = [];
  List<ImageModel> deletedImageList = RxList.empty();

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
    siteAddress.value.text = '';
    cityModifier.value = null;
    typeOfSiteModifier.value = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    contractorName.value.dispose();
    siteAddress.value.dispose();
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
        dbType: "insertCollege",
        companyId: AuthController.instance.user?.companyId,
        contractorName: contractorName.value.text,
        contractorAddress: contractorAddress.value.text,
        contractorPhone: int.parse(contractorPhone.value.text),
        siteCityId: cityModifier.value?.cityId ?? 1,
        siteAddress: siteAddress.value.text,
        siteType: typeOfSiteModifier.value?.siteTypeValue,
        // mapLink: ,
        remarks: remarks.value.text,
        giveAWays: giveaways.value.text,
        painters: paintersList,
        createdBy: AuthController.instance.user!.name ?? "admin",
        createdAt: DateTime.now().toString(),
        cityName: cityModifier.value?.cityName,
      );
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
      Get.snackbar('Congrats!', 'College is inserted.',
          backgroundColor: AppColors.blue, colorText: AppColors.white);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "please try again");
    }
  }

  void updateSite() async {
    isLoading(true);
    try {
      ImageModel dummy;
      for (int i = 0; i < uploadedImages.length; i++) {
        imageList.add(uploadedImages[i]);
      }
      site = SiteModel(
        dbType: "updateCollege",
        companyId: AuthController.instance.user?.companyId,
        contractorName: contractorName.value.text,
        contractorAddress: contractorAddress.value.text,
        contractorPhone: int.parse(contractorPhone.value.text),
        siteCityId: cityModifier.value?.cityId ?? 1,
        siteAddress: siteAddress.value.text,
        siteType: typeOfSiteModifier.value?.siteTypeValue,
        // mapLink: ,
        remarks: remarks.value.text,
        giveAWays: giveaways.value.text,
        painters: paintersList,
        updatedBy: AuthController.instance.user!.name ?? "admin",
        updatedAt: DateTime.now().toString(),
        cityName: cityModifier.value?.cityName,
        images: deletedImageList,
      );
      await SiteRepo.updateOutlet(site!).then((value) {
        HomePageController.instance.listOfSites
            .removeWhere((col) => col.siteId == site!.siteId);
      });
      for (int i = 0; i < selectedImages.length; i++) {
        String imageUrl = await uploadImage(
            site!.siteId!, 'site', Utility.base64String(selectedImages[i]));
        dummy = ImageModel(imageId: i, path: imageUrl, siteId: site!.siteId);
        imageList.add(dummy);
      }
      site?.images = imageList;
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
        paintersList.value = site!.painters ?? [];
        selectedImages.clear();
        uploadedImages.clear();
        deletedId.clear();
        deletedImageList.clear();
        if (site!.images!.isNotEmpty) {
          for (int i = 0; i < site!.images!.length; i++) {
            uploadedImages.add(site!.images![i]);
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
    citiesList.addAll(await SiteRepo.getCitesData());
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
          // File file=
          selectedImages.add(await imgFile.readAsBytes());
          // imgString.value = Utility.base64String(await imgFile.readAsBytes());
          // selectedImage.value = Utility.dataFromBase64String(imgString.value!);
          // sendImgString.value = await AttendanceRepo.uploadImage(
          //     imgString.value!,
          //     'attendancepic',
          //     AuthController.instance.user!,
          //     HomePageController.instance.attendance.value?.attendedId == null
          //         ? 0
          //         : HomePageController.instance.attendance.value!.attendedId!);
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
}
