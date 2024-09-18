import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/style/app_color.dart';
import '../widgets/ran_painter_screen_card.dart';
import './add_ran_painter_screen.dart';
import './controller/ran_painter_controller.dart';

import '../../widgets/general_widgets.dart';
import '../home/controller/home_controller.dart';

import 'model/ran_painter_model.dart';

class ListOfRanPainterScreen extends GetView<RanPainterController> {
  static const routeName = '/list-of-naka-painter';

  const ListOfRanPainterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<RanPainterModel> ranPainter = [];
    ranPainter = HomePageController.instance.listOfRanPainters;
    return Scaffold(
      appBar: appBarWidget(
        title: ('Naka List'),
        actions: [
          IconButton(
            onPressed: () {
              controller.selectedImages.clear();
              Get.toNamed(AddRanPainterScreen.routeName);
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
            Get.toNamed(AddRanPainterScreen.routeName);
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
                        elevation: MaterialStateProperty.all(2),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.white),
                        surfaceTintColor:
                            MaterialStateProperty.all(AppColors.white),
                        // textInputAction: TextInputAction.done,
                        leading: const Icon(Icons.search),
                        hintText: 'Search painter',
                        onChanged: HomePageController.instance.searchPainters,
                      ),
                    ),
                    if (ranPainter.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text(
                            'No painters available',
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, i) {
                            return RanPainterScreenCard(ranPainter[i]);
                          },
                          itemCount: ranPainter.length,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
