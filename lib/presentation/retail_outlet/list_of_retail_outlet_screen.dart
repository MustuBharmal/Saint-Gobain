import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/style/app_color.dart';
import '../widgets/retail_outlet_screen_card.dart';
import './add_retail_outlet_screen.dart';
import './controller/retail_outlet_controller.dart';

import '../../widgets/general_widgets.dart';
import '../home/controller/home_controller.dart';

import 'model/retail_outlet_model.dart';

class ListOfRetailOutletScreen extends GetView<RetailOutletController> {
  static const routeName = '/list-of-outlet';

  const ListOfRetailOutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RetailOutletModel> outlets = [];
    outlets = HomePageController.instance.listOfRetailOutlets.value;
    return Scaffold(
      appBar: appBarWidget(
        title: ('List of Retail Outlets'),
        actions: [
          IconButton(
            onPressed: () {
              controller.selectedImages.clear();
              Get.toNamed(AddRetailOutletScreen.routeName);
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
            Get.toNamed(AddRetailOutletScreen.routeName);
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
                        hintText: 'Search Retail Outlet',
                        onChanged: HomePageController.instance.searchOutlets,
                      ),
                    ),
                    if (outlets.isEmpty)
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
                            return RetailOutletScreenCard(outlets[i]);
                          },
                          itemCount: outlets.length,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
