import 'package:flutter/material.dart';

import '../../core/style/app_color.dart';
import '../../widgets/general_widgets.dart';

class AddItemButton extends StatelessWidget {
  final Function onTapFun;
  final String buttonText;

  const AddItemButton(
      {required this.onTapFun, required this.buttonText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0, 10)),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.shadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          myText(
              text: buttonText,
              style:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
          IconButton(
              onPressed: () {
                onTapFun();
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }
}
