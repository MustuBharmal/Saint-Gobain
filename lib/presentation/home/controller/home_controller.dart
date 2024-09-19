import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controller/auth_controller.dart';
import '../../naka_painters/model/ran_painter_model.dart';
import '../../retail_outlet/model/retail_outlet_model.dart';
import '../../common_models/common_model.dart';
import '../../site/model/site_model.dart';
import '../repo/homepage_repo.dart';

class HomePageController extends GetxController {
  static HomePageController get instance => Get.find<HomePageController>();
  Rx<bool> switchBool = Rx(false);
  RxInt lengthOfSites = RxInt(0);
  RxInt lengthOfOutlets = RxInt(0);
  RxInt lengthOfRanPainters = RxInt(0);
  RxList<SiteModel> listOfSites = RxList.empty();
  RxList<RetailOutletModel> listOfRetailOutlets = RxList.empty();
  RxList<RanPainterModel> listOfRanPainters = RxList.empty();
  final List<SiteModel> _allSites = [];
  final List<RetailOutletModel> _allRetailOutlets = [];
  final List<RanPainterModel> _allRanPainters = [];
  var isLoading = false.obs;
  RxList<CityModel> citiesList = RxList.empty();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getList();
    getCities();
  }

  getCities() async {
    citiesList.clear();
    citiesList.addAll(await HomePageRepo.getCitesData());
  }

  void showOtherUserContextMenu() {
    showMenu(
      context: Get.context!,
      position: const RelativeRect.fromLTRB(10.0, 0.0, 0.0, 0.0),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text('Logout User'),
        ),
      ],
      elevation: 0.0,
    ).then((value) {
      // Handle the selected menu item here
      if (value != null) {
        switch (value) {
          case 1:
            showDialog(
              context: Get.context!,
              builder: (context) => SimpleDialog(
                backgroundColor: Colors.white,
                title: const Text("You want to logout?"),
                children: [
                  SimpleDialogOption(
                    child: const Text("Yes"),
                    onPressed: () {
                      AuthController.instance.logout();
                    },
                  ),
                  SimpleDialogOption(
                    child: const Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
            break;
        }
      }
    });
  }

  DateTime now = DateTime.now();

  getList() async {
    isLoading(true);
    try {
      _allSites.clear();
      listOfSites.clear();
      _allSites.addAll(await HomePageRepo.getListOfSites());
      listOfSites.addAll(_allSites.reversed);
      lengthOfSites.value = listOfSites.length;
      _allRanPainters.clear();
      listOfRanPainters.clear();
      _allRanPainters.addAll(await HomePageRepo.getListOfRanPainters());
      listOfRanPainters.addAll(_allRanPainters);
      lengthOfRanPainters.value = listOfRanPainters.length;
      _allRetailOutlets.clear();
      listOfRetailOutlets.clear();
      _allRetailOutlets.addAll(await HomePageRepo.getListOfRetailOutlets());
      listOfRetailOutlets.addAll(_allRetailOutlets);
      lengthOfOutlets.value = listOfRetailOutlets.length;
    } catch (e) {
      Get.snackbar('Error', 'Please try again later.',
          colorText: Colors.white, backgroundColor: Colors.blue);
      isLoading(false);
      update();
    }
    isLoading(false);
  }

  updatingSites(SiteModel site){
    _allSites.add(site);
  }

  searchSites(String query) {
    if (query == '') {
      listOfSites.clear();
      listOfSites.addAll(_allSites.reversed);
    } else {
      listOfSites.clear();
      listOfSites.addAll(_allSites.reversed.where((element) =>
          element.contractorName?.toLowerCase().contains(query.toLowerCase()) ??
          false));
    }
  }

  updatingOutlets(RetailOutletModel outlets){
    _allRetailOutlets.add(outlets);
  }

  searchOutlets(String query) {
    if (query == '') {
      listOfRetailOutlets.clear();
      listOfRetailOutlets.addAll(_allRetailOutlets.reversed);
    } else {
      listOfRetailOutlets.clear();
      listOfRetailOutlets.addAll(_allRetailOutlets.reversed.where((element) =>
      element.outletName?.toLowerCase().contains(query.toLowerCase()) ??
          false));
    }
  }

  updatingRan(RanPainterModel ran){
    _allRanPainters.add(ran);
  }

  searchPainters(String query) {
    if (query == '') {
      listOfRanPainters.clear();
      listOfRanPainters.addAll(_allRanPainters.reversed);
    } else {
      listOfRanPainters.clear();
      listOfRanPainters.addAll(_allRanPainters.reversed.where((element) =>
      element.painterName?.toLowerCase().contains(query.toLowerCase()) ??
          false));
    }
  }
}
