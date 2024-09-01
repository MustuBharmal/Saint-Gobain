import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../auth/controller/auth_controller.dart';
import '../../site/model/site_model.dart';
import '../repo/homepage_repo.dart';

class HomePageController extends GetxController {
  static HomePageController get instance => Get.find<HomePageController>();
  Rx<bool> switchBool = Rx(false);
  RxInt lengthOfListOfSites = RxInt(0);
  RxInt lengthOfListOfStudents = RxInt(0);
  final List<SiteModel> _allSites = [];
  RxList<SiteModel> listOfSites = RxList.empty();
  /*final List<StudentModel> _allStudents = [];
  RxList<StudentModel> listOfStudents = RxList.empty();*/
  var isLoading = false.obs;
  /*RxList<CityModel> citiesList = RxList.empty();
  RxList<QuestionModel> questionsList = RxList.empty();*/

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getList();
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

  /*getCities() async {
    citiesList.clear();
    citiesList.addAll(
        await CollegeRepo.getCitesData(AuthController.instance.user!.state!));
  }*/

  /*getQuestions() async {
    questionsList.clear();
    questionsList.addAll(await HomePageRepo.getListOfQuestions());
  }*/

  DateTime now = DateTime.now();

  getList() async {
    isLoading(true);
    try {
      _allSites.clear();
      listOfSites.clear();
      _allSites.addAll(await HomePageRepo.getListOfSites());
      listOfSites.addAll(_allSites);
      lengthOfListOfSites.value = listOfSites.length;
      /*_allStudents.clear();
      _allStudents.addAll(await HomePageRepo.getListOfStudents());
      listOfStudents.addAll(_allStudents);
      lengthOfListOfStudents.value = listOfStudents.length;
      */
    } catch (e) {
      Get.snackbar('Error', 'Please try again later.',
          colorText: Colors.white,
          backgroundColor: Colors.blue);
      isLoading(false);
      update();
    }
    isLoading(false);
  }

  searchColleges(String query) {
    if (query == '') {
      listOfSites.clear();
      listOfSites.addAll(_allSites);
    } else {
      listOfSites.clear();
      listOfSites.addAll(_allSites.where((element) =>
          element.contractorName?.toLowerCase().contains(query.toLowerCase()) ??
          false));
    }
  }
}
