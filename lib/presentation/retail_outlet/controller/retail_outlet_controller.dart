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
import '../../site/model/common_model.dart';
import '../model/common_model.dart';
import '../model/retail_outlet_model.dart';
import '../repo/retail_outlet_repo.dart';

class RetailOutletController extends GetxController {
  Rx<TextEditingController> outletName = TextEditingController().obs;
  Rx<TextEditingController> outletAddress = TextEditingController().obs;
  Rx<TextEditingController> outletOwner = TextEditingController().obs;
  Rx<TextEditingController> outletPhone = TextEditingController().obs;
  Rx<TextEditingController> giveaways = TextEditingController().obs;
  RxList<Customers> customerList = RxList.empty();
  RxList<CityModel> citiesList = RxList.empty();
  RxList<CustomerTypeModel> typeOfCustomerList = RxList.empty();
  RxList<Customers> typeOfCustomerListSec = RxList.empty();
  RxList<RetailOutletModel> retailOutletList = RxList.empty();
  RetailOutletModel? outlet;
  var isLoading = false.obs;
  var isEditLoading = false.obs;
  Rx<CityModel?> cityModifier = Rx(null);
  Rx<CustomerTypeModel?> typeOfCustomerModifier = Rx(null);
  Rx<RetailOutletModel?> retailOutletModifier = Rx(null);
  RxList<Uint8List> selectedImages = RxList.empty();
  RxList<ImageModel> uploadedImages = RxList.empty();
  List<int> deletedId = [];
  List<ImageModel> imageList = [];
  List<ImageModel> deletedImageList = RxList.empty();

  static RetailOutletController get instance =>
      Get.find<RetailOutletController>();

  @override
  void onInit() {
    // TODO: implement onInit
    getCities();
    getTypeOfCustomers();
    super.onInit();
  }

  void clear() {
    outletName.value.text = '';
    outletPhone.value.text = '';
    outletAddress.value.text = '';
    outletOwner.value.text = '';
    giveaways.value.text = '';
    cityModifier.value = null;
    typeOfCustomerModifier.value = null;
    customerList.value = [];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    outletName.value.dispose();
    outletPhone.value.dispose();
    outletAddress.value.dispose();
    outletOwner.value.dispose();
    giveaways.value.dispose();
  }

  Future<String> uploadImage(
      int siteId, String imageKey, String imageData) async {
    return await RetailOutletRepo.uploadSiteImage(
        imageData, imageKey, AuthController.instance.user!, siteId);
  }

  void insertOutlet() async {
    isLoading(true);
    try {
      ImageModel dummy;
      outlet = RetailOutletModel(
        dbType: "insertOutlet",
        outletName: outletName.value.text,
        outletAddress: outletAddress.value.text,
        outletCityId: cityModifier.value?.cityId ?? 1,
        outletOwner: outletOwner.value.text,
        outletPhone: (outletPhone.value.text),
        // mapLink: ,
        giveaways: giveaways.value.text,
        companyId: AuthController.instance.user?.companyId,
        customers: customerList,
        createdBy: AuthController.instance.user!.name ?? "admin",
        createdAt: DateTime.now().toString(),
        updatedBy: '',
        updatedAt: '',
        cityName: cityModifier.value?.cityName,
      );
      LogUtil.debug(outlet?.toJson());
      outlet?.outletId = await RetailOutletRepo.insertOutlet(outlet!);
      if (outlet?.outletId != null) {
        for (int i = 0; i < selectedImages.length; i++) {
          String imageUrl = await uploadImage(outlet!.outletId!, 'site',
              Utility.base64String(selectedImages[i]));
          dummy =
              ImageModel(imageId: i, path: imageUrl, siteId: outlet!.outletId);
          imageList.add(dummy);
        }
      }
      outlet?.images = imageList;
      HomePageController.instance.listOfRetailOutlets.add(outlet!);
      isLoading(false);
      Get.offAllNamed(HomePage.routeName);
      HomePageController.instance.lengthOfListOfSites.value =
          HomePageController.instance.lengthOfListOfSites.value + 1;
      Get.snackbar('Congrats!', 'Retail Outlet is inserted.',
          backgroundColor: AppColors.blue, colorText: AppColors.white);
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "please try again");
    }
  }

  void updateOutlet() async {
    isLoading(true);
    try {
      ImageModel dummy;
      for (int i = 0; i < uploadedImages.length; i++) {
        imageList.add(uploadedImages[i]);
      }
      outlet = RetailOutletModel(
        dbType: "updateOutlet",
        outletId: outlet!.outletId,
        companyId: AuthController.instance.user?.companyId,
        outletName: outletName.value.text,
        outletAddress: outletAddress.value.text,
        outletCityId: cityModifier.value?.cityId ?? 1,
        outletOwner: outletOwner.value.text,
        outletPhone: (outletPhone.value.text),
        // mapLink: ,
        giveaways: giveaways.value.text,
        customers: customerList,
        createdBy: outlet?.createdBy ?? "admin",
        createdAt: outlet?.createdAt ?? DateTime.now().toString(),
        updatedBy: AuthController.instance.user!.name ?? "admin",
        updatedAt: DateTime.now().toString(),
        cityName: cityModifier.value?.cityName,
        images: deletedImageList,
      );
      await RetailOutletRepo.updateOutlet(outlet!).then((value) {
        HomePageController.instance.listOfRetailOutlets
            .removeWhere((col) => col.outletId == outlet!.outletId);
      });
      for (int i = 0; i < selectedImages.length; i++) {
        String imageUrl = await uploadImage(
            outlet!.outletId!, 'site', Utility.base64String(selectedImages[i]));
        dummy =
            ImageModel(imageId: i, path: imageUrl, siteId: outlet!.outletId);
        imageList.add(dummy);
      }
      outlet?.images = imageList;
      LogUtil.debug(outlet?.toJson());
      HomePageController.instance.listOfRetailOutlets.add(outlet!);
      isLoading(false);
      Dialogs.showSnackBar(Get.context, "Retail outlet updated");

      Get.back();
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', "$e");
    }
  }

  void editSite() async {
    isEditLoading(true);
    outlet = Get.arguments;
    try {
      if (outlet != null) {
        outletName.value.text = outlet!.outletName ?? '';
        outletAddress.value.text = outlet!.outletAddress ?? '';
        outletOwner.value.text = outlet!.outletOwner ?? '';
        outletPhone.value.text = outlet!.outletPhone.toString();
        giveaways.value.text = outlet!.giveaways ?? '';
        cityModifier.value = citiesList.firstWhereOrNull(
            (element) => element.cityName == outlet!.cityName);
        setCityValue(cityModifier.value);
        setSiteTypeValue(typeOfCustomerModifier.value?.siteTypeValue);
        customerList.clear();
        selectedImages.clear();
        uploadedImages.clear();
        deletedId.clear();
        deletedImageList.clear();
        if (outlet!.images!.isNotEmpty) {
          for (int i = 0; i < outlet!.images!.length; i++) {
            uploadedImages.add(outlet!.images![i]);
          }
        }
        if (outlet!.customers!.isNotEmpty) {
          for (int i = 0; i < outlet!.customers!.length; i++) {
            customerList.add(outlet!.customers![i]);
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

  getTypeOfCustomers() async {
    typeOfCustomerList.clear();
    typeOfCustomerList
        .addAll(await RetailOutletRepo.getTypeOfCustomerTypeData());
    for(var e in typeOfCustomerList.value){
      typeOfCustomerListSec.add(Customers(type: e.siteTypeValue));
    }
  }

  void setCityValue(CityModel? city) {
    cityModifier.value = city;
  }

  void setSiteTypeValue(String? siteType) {
    typeOfCustomerModifier.value?.siteTypeValue = siteType;
  }

  void setRetailOutletValue(RetailOutletModel? site) {
    retailOutletModifier.value = site;
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
}
