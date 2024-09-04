import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/global_variables.dart';
import '../../widgets/general_widgets.dart';
import '../site/model/site_model.dart';

class PaintersAddingWidget extends StatelessWidget {
  final List<Painters> paintersList;

  const PaintersAddingWidget({required this.paintersList, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          reverse: true,
          itemCount: paintersList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myText(
                    text: "Painter Name",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18)),
                SizedBox(
                  height: Get.height * dropSize,
                ),
                myTextQuesField(
                    text: "Name",
                    initialValue: paintersList[index].name,
                    validator: (String input) {
                      return null;
                    },
                    onChanged: (String? val) {
                      if (val!.isNotEmpty) {
                        paintersList[index].name = val;
                      }
                    }),
                myText(
                    text: "Painter Phone Number",
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 18)),
                SizedBox(
                  height: Get.height * dropSize,
                ),
                myTextQuesField(
                    text: "Phone Number",
                    textInputType: TextInputType.phone,
                    maxLength: 10,
                    initialValue: paintersList[index].phone,
                    validator: (String input) {
                      return null;
                    },
                    onChanged: (String? val) {
                      if (val!.isNotEmpty) {
                        paintersList[index].phone = val;
                      }
                    }),
              ],
            );
          },
        ),
      ],
    );
  }
}
