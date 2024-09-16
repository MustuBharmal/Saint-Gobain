import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/global_variables.dart';
import '../../core/style/styles.dart';
import '../../widgets/general_widgets.dart';

class RadioButtonWidget extends StatelessWidget {
  RadioButtonWidget(
      {required this.radioButtonValue,
      required this.onPressFun,
      required this.titleText,
      super.key});

  RxString radioButtonValue;
  Function onPressFun;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    List<String> options = ["Yes", "No"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        myText(
            text: titleText,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
        SizedBox(
          height: Get.height * dropSize,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.map((option) {
              return Container(
                width: Get.width * 0.32,
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: RadioListTile(
                  activeColor: Colors.black,
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    option,
                    style: subtitleStyle2,
                  ),
                  value: option,
                  groupValue: radioButtonValue.value,
                  onChanged: (value) {
                    onPressFun(value);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
