import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constant/global_variables.dart';
import '../../core/style/app_color.dart';
import '../../widgets/general_widgets.dart';
import '../common_models/common_type_models.dart';
import '../widgets/custom_radio_widget.dart';
import './controller/ran_painter_controller.dart';

class AddRanPainterScreen extends GetView<RanPainterController> {
  AddRanPainterScreen({super.key});

  static const routeName = '/add-naka-screen';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.arguments != null ? controller.editPainter() : controller.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
        title:
            Get.arguments != null ? "Edit Naka activity" : "Add Naka activity",
        leading: const Icon(CupertinoIcons.arrow_left),
      ),
      body: Obx(() => (controller.isLoading.value ||
              controller.isEditLoading.value)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        myText(
                            text: "Select naka type",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        DropdownButtonFormField<CommonTypeModel>(
                          validator: (CommonTypeModel? input) {
                            if (input?.commonTypeValue == null) {
                              Get.snackbar('Warning', 'Select naka type',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.blue);
                              return '';
                            }
                            return null;
                          },
                          isExpanded: true,
                          menuMaxHeight: 500,
                          elevation: 16,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(top: 5, left: 20),
                            errorStyle: const TextStyle(fontSize: 0),
                            hintStyle: TextStyle(
                              color: AppColors.genderTextColor,
                            ),
                            hintText: ' -select- ',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          value: controller.typeOfPainterModifier.value,
                          onChanged: controller.setSiteTypeValue,
                          items: controller.typeOfPaintersList
                              .map<DropdownMenuItem<CommonTypeModel>>(
                                  (CommonTypeModel value) {
                                return DropdownMenuItem<CommonTypeModel>(
                                  value: value,
                                  child: Text(
                                    value.commonTypeValue ?? '-',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xffA6A6A6),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),

                        myText(
                            text: "Naka name",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        myTextField(
                          text: "Name",
                          controller: controller.painterName.value,
                          validator: (String input) {
                            if (input.isEmpty) {
                              Get.snackbar('Warning', 'Name is required.',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.blue);
                              return '';
                            }
                            return null;
                          },
                        ),
                        myText(
                            text: "Naka phone number",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        myTextField(
                          text: "Phone Number",
                          controller: controller.painterPhone.value,
                          textInputType: TextInputType.phone,
                          maxLength: 10,
                          validator: (String input) {
                            if (input.isEmpty) {
                              Get.snackbar(
                                  'Warning', 'Phone Number is required.',
                                  colorText: Colors.white,
                                  backgroundColor: Colors.blue);
                              return '';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            myText(
                              text: "Geo Location",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                            OutlinedButton(
                                onPressed: () async {
                                  await controller.getCurrentPosition();
                                },
                                child: const Icon(Icons.refresh))
                          ],
                        ),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        controller.isLocationFetched.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : myTextField(
                                text: "",
                                controller: controller.geoLocation.value,
                                readOnly: true,
                                textInputType: TextInputType.phone,
                                maxLines: 3,
                                validator: (String input) {
                                  if (input.isEmpty) {
                                    Get.snackbar(
                                        'Warning', 'Location is required.',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.blue);
                                    return '';
                                  }
                                  return null;
                                },
                              ),
                        RadioButtonWidget(
                            radioButtonValue: controller.engagement,
                            titleText: 'Was there engagement?',
                            onPressFun: (value) {
                              controller.engagement.value = value;
                            }),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        RadioButtonWidget(
                            radioButtonValue: controller.videoShown,
                            titleText: 'Is video shown?',
                            onPressFun: (value) {
                              controller.videoShown.value = value;
                            }),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        myText(
                            text: "Giveaways",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        myTextField(
                          text: "Giveaways",
                          controller: controller.giveaways.value,
                          validator: (String input) {
                            return null;
                          },
                        ),
                        myText(
                            text: "Remarks",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 18)),
                        SizedBox(
                          height: Get.height * dropSize,
                        ),
                        myTextField(
                          text: "Remarks",
                          controller: controller.remarks.value,
                          validator: (String input) {
                            return null;
                          },
                        ),
                        if (Get.arguments == null)
                          Wrap(
                            children: [
                              ...List.generate(
                                controller.selectedImages.length,
                                (index) => Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: Get.width * 0.39,
                                    width: Get.width * 0.39,
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      children: [
                                        Image.memory(
                                          controller.selectedImages[index],
                                          fit: BoxFit.cover,
                                          height: Get.width * 0.39,
                                          width: Get.width * 0.39,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                controller.removeImage(index);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (controller.selectedImages.length < 15)
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(bottomSheet());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: Get.width * 0.39,
                                    width: Get.width * 0.39,
                                    clipBehavior: Clip.hardEdge,
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset('assets/images/img.png'),
                                  ),
                                )
                            ],
                          )
                        else
                          Wrap(
                            children: [
                              ...List.generate(
                                controller.uploadedImages.length,
                                (index) => Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: Get.width * 0.4,
                                    width: Get.width * 0.4,
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      children: [
                                        Image.network(
                                          controller
                                              .uploadedImages[index].path!,
                                          fit: BoxFit.cover,
                                          height: Get.width * 0.4,
                                          width: Get.width * 0.4,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                controller
                                                    .removeUploadedImage(index);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.red,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ...List.generate(
                                controller.selectedImages.length,
                                (index) => Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: Get.width * 0.4,
                                    width: Get.width * 0.4,
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      children: [
                                        Image.memory(
                                          controller.selectedImages[index],
                                          fit: BoxFit.cover,
                                          height: Get.width * 0.4,
                                          width: Get.width * 0.4,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                              onPressed: () {
                                                controller.removeImage(index);
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.white,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (controller.uploadedImages.length +
                                      controller.selectedImages.length <
                                  15)
                                InkWell(
                                  onTap: () {
                                    Get.bottomSheet(bottomSheet());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    height: Get.width * 0.4,
                                    width: Get.width * 0.4,
                                    clipBehavior: Clip.hardEdge,
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset('assets/images/img.png'),
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(
                          height: Get.height * size,
                        ),
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: SizedBox(
                                    height: 50,
                                    width: Get.width * 0.5,
                                    child: elevatedButton(
                                      text: Get.arguments != null
                                          ? "Edit naka activity"
                                          : "Add naka activity",
                                      onPress: () {
                                        // controller.uploadImage();
                                        // return;
                                        /*if (!formKey.currentState!
                                              .validate()) {
                                            LogUtil.warning(
                                                'error in inserting or updating College');
                                            return;
                                          }*/
                                        Get.arguments != null
                                            ? controller.updatePainter()
                                            : controller.insertPainter();
                                      },
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
    );
  }

  Widget bottomSheet() {
    return Container(
      // height: 100.0,
      width: Get.width,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
      padding: const EdgeInsets.only(
        top: 20,
        // vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            "Capture Image",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () async {
              Get.back();
              controller.pickPic(ImageSource.camera);
            },
            icon: const Icon(
              Icons.camera_alt_outlined,
            ),
            label: const Text(
              "Camera",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () async {
              Get.back();
              controller.pickPic(ImageSource.gallery);
            },
            icon: const Icon(
              Icons.image_outlined,
            ),
            label: const Text(
              "Gallery",
            ),
          ),
        ],
      ),
    );
  }
}
