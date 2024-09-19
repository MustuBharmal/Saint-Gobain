import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../core/style/app_color.dart';
import '../../core/style/styles.dart';
import '../../widgets/general_widgets.dart';
import '../auth/controller/auth_controller.dart';
import '../naka_painters/list_of_ran_painter_screen.dart';
import '../retail_outlet/list_of_retail_outlet_screen.dart';
import '../site/list_of_sites_screen.dart';
import '../widgets/home_screen_dart.dart';
import 'controller/home_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  static const routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: 'Dashboard',
        actions: [
          myText(
              text:
              AuthController.instance.user!.name!.toUpperCase(),
              style: subtitleStyle2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                controller.showOtherUserContextMenu();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: appVersion(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: myText(
                  text:
                      AuthController.instance.user!.companyName!.toUpperCase(),
                  style: subtitleStyle3),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                height: Get.height * 0.125,
                width: Get.width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: Offset(0, 25)),
                  ],
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width * 0.20,
                            height: Get.height * 0.08,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blue),
                            child: Obx(
                              () => Center(
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : Text(
                                        controller.lengthOfOutlets.value
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white),
                                      ),
                              ),
                            ),
                          ),
                          myText(
                              text: 'Outlets',
                              style: TextStyle(color: AppColors.black))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width * 0.20,
                            height: Get.height * 0.08,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blue),
                            child: Obx(
                              () => Center(
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: AppColors.white,
                                      )
                                    : Text(
                                        controller.lengthOfSites.toString(),
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.white),
                                      ),
                              ),
                            ),
                          ),
                          myText(
                              text: 'Sites',
                              style: TextStyle(color: AppColors.black))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Container(
                            width: Get.width * 0.20,
                            height: Get.height * 0.08,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: AppColors.blue),
                            child: Obx(
                                  () => Center(
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                  color: AppColors.white,
                                )
                                    : Text(
                                  controller.lengthOfRanPainters.toString(),
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          myText(
                              text: 'Naka',
                              style: TextStyle(color: AppColors.black))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeScreenCard(
                  color: Colors.orange,
                  imageFile: 'assets/images/to-do-list.png',
                  label: "Retail Outlet List",
                  onTap: () {
                    Get.toNamed(ListOfRetailOutletScreen.routeName);
                  },
                ),
                HomeScreenCard(
                  color: Colors.lightGreen,
                  imageFile: 'assets/images/interested.png',
                  label: "Site List",
                  onTap: () {
                    Get.toNamed(ListOfSitesScreen.routeName);
                  },
                ),
              ],
            ),
            HomeScreenCard(
              color: Colors.lightGreen,
              imageFile: 'assets/images/interested.png',
              label: "Naka List",
              onTap: () {
                Get.toNamed(ListOfRanPainterScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget appVersion() {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshots) {
        if (snapshots.hasError) {
          return Center(child: myText(text: snapshots.error.toString()));
        } else if (snapshots.hasData) {
          PackageInfo packageInfo = snapshots.data!;
          return myText(
            text: 'App Version - ${packageInfo.version}',
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
