import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/style/app_color.dart';
import '../widgets/site_screen_card.dart';
import './add_site_screen.dart';
import './controller/site_controller.dart';

import '../../widgets/general_widgets.dart';
import '../home/controller/home_controller.dart';

import 'model/site_model.dart';

class ListOfSitesScreen extends GetView<SitesController> {
  static const routeName = '/list-of-sites';

  const ListOfSitesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<SiteModel> sites = [];
    sites = HomePageController.instance.listOfSites;
    return Scaffold(
      appBar: appBarWidget(
        title: ('List of Sites'),
        actions: [
          IconButton(
            onPressed: () {
              controller.selectedImages.clear();
              controller.selectedPaintersList.clear();
              Get.toNamed(AddSiteScreen.routeName);
            },
            icon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0, right: 16),
        child: FloatingActionButton(
          onPressed: () {
            controller.selectedImages.clear();
            controller.selectedPaintersList.clear();
            Get.toNamed(AddSiteScreen.routeName);
          },
          backgroundColor: AppColors.white2,
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      body: Obx(
        () => Container(
          child: controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SearchBar(
                        elevation: WidgetStateProperty.all(2),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.white),
                        surfaceTintColor:
                            WidgetStateProperty.all(AppColors.white),
                        // textInputAction: TextInputAction.done,
                        leading: const Icon(Icons.search),
                        hintText: 'Search Sites',
                        onChanged: HomePageController.instance.searchSites,
                      ),
                    ),
                    if (sites.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text(
                            'No sites available',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return SiteScreenCard(sites[i]);
                          },
                          itemCount: sites.length,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
