import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/global_variables.dart';
import '../../core/style/app_color.dart';
import '../../widgets/general_widgets.dart';
import '../retail_outlet/model/retail_outlet_model.dart';

class CustomersAddingWidget extends StatelessWidget {
  final List<Customers> uploadedCustomerList;
  final List<Customers> typeOfCustomList;

  const CustomersAddingWidget(
      {required this.uploadedCustomerList,
      required this.typeOfCustomList,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          reverse: true,
          itemCount: uploadedCustomerList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                    text: "Customer name",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18)),
                SizedBox(
                  height: Get.height * dropSize,
                ),
                myTextQuesField(
                    text: "Name",
                    initialValue: uploadedCustomerList[index].name,
                    validator: (String input) {
                      return null;
                    },
                    onChanged: (String? val) {
                      if (val!.isNotEmpty) {
                        uploadedCustomerList[index].name = val;
                      }
                    }),
                myText(
                    text: "Customer phone number",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18)),
                SizedBox(
                  height: Get.height * dropSize,
                ),
                myTextQuesField(
                    text: "Phone Number",
                    textInputType: TextInputType.phone,
                    maxLength: 10,
                    initialValue: uploadedCustomerList[index].phone,
                    validator: (String input) {
                      return null;
                    },
                    onChanged: (String? val) {
                      if (val!.isNotEmpty) {
                        uploadedCustomerList[index].phone = val;
                      }
                    }),
                myText(
                    text: "Select customer type",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18)),
                SizedBox(
                  height: Get.height * dropSize,
                ),
                DropdownButtonFormField<String>(
                  validator: (String? input) {
                    if (input == null) {
                      Get.snackbar('Warning', 'Select customer type.',
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
                    contentPadding: const EdgeInsets.only(top: 5, left: 20),
                    errorStyle: const TextStyle(fontSize: 0),
                    hintStyle: TextStyle(
                      color: AppColors.genderTextColor,
                    ),
                    hintText: ' -select- ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  value: uploadedCustomerList[index].type,
                  onChanged: (value) async {
                    if (value!.isNotEmpty) {
                      uploadedCustomerList[index].type = value;
                    }
                  },
                  items: typeOfCustomList
                      .map<DropdownMenuItem<String>>((Customers value) {
                    return DropdownMenuItem<String>(
                      value: value.type,
                      child: Text(
                        value.type ?? '',
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
              ],
            );
          },
        ),
      ],
    );
  }
}
