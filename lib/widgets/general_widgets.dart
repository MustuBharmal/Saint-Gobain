import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/style/app_color.dart';
import '../presentation/auth/controller/auth_controller.dart';

Widget myText({text, style, textAlign, maxLines}) {
  return Text(
    text,
    style: style,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
    softWrap: false,
  );
}

Widget myTextField(
    {text,
    String? prefixIcon,
    int maxLines = 1,
    int? maxLength,
    TextEditingController? controller,
    TextInputType textInputType = TextInputType.text,
    bool readOnly = false,
    Function? validator}) {
  return Container(
    // height: 45,
    margin: EdgeInsets.only(bottom: Get.height * 0.02),
    child: TextFormField(
      maxLength: maxLength,
      readOnly: readOnly,
      keyboardType: textInputType,
      validator: (input) => validator!(input),
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        counterText: '',
        labelText: text,
        contentPadding: const EdgeInsets.only(top: 5, left: 20),
        errorStyle: const TextStyle(fontSize: 0),
        hintStyle: TextStyle(
          color: AppColors.genderTextColor,
        ),
        hintText: text,
        prefixIcon: prefixIcon == null
            ? null
            : Image.asset(
                prefixIcon,
                cacheHeight: 20,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

Widget myTextQuesField({
  text,
  String? prefixIcon,
  int maxLines = 1,
  int? maxLength,
  TextEditingController? controller,
  TextInputType textInputType = TextInputType.text,
  bool readOnly = false,
  Function? validator,
  Function? onChanged,
  String? initialValue,
}) {
  return Container(
    // height: 45,
    margin: EdgeInsets.only(bottom: Get.height * 0.02),
    child: TextFormField(
      validator: (input) => validator!(input),
      onChanged: (input) => onChanged!(input),
      initialValue: initialValue,
      maxLength: maxLength,
      readOnly: readOnly,
      keyboardType: textInputType,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        counterText: '',
        labelText: text,
        contentPadding: const EdgeInsets.only(top: 5, left: 20),
        errorStyle: const TextStyle(fontSize: 0),
        hintStyle: TextStyle(
          color: AppColors.genderTextColor,
        ),
        hintText: text,
        prefixIcon: prefixIcon == null
            ? null
            : Image.asset(
          prefixIcon,
          cacheHeight: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

Widget iconTitleContainer(
    {text,
    String? prefixIcon,
    Function? onPress,
    bool isReadOnly = false,
    TextInputType textInputType = TextInputType.text,
    TextEditingController? controller,
    Function? validator,
    double width = 150,
    double height = 40}) {
  return Container(
    margin: EdgeInsets.only(bottom: Get.height * 0.02),
    child: TextFormField(
      validator: (String? input) => validator!(input!),
      onTap: () => onPress!(),
      controller: controller,
      readOnly: isReadOnly,
      keyboardType: textInputType,
      decoration: InputDecoration(
        counterText: '',
        labelText: text,
        contentPadding: const EdgeInsets.only(top: 5, left: 20),
        errorStyle: const TextStyle(fontSize: 0),
        hintStyle: TextStyle(
          color: AppColors.genderTextColor,
        ),
        hintText: text,
        prefixIcon: prefixIcon == null
            ? null
            : Image.asset(
                prefixIcon,
                cacheHeight: 20,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

PreferredSizeWidget appBarWidget({String? title, actions, Icon? leading}) {
  return AppBar(
    actions: actions,
    backgroundColor: AppColors.white,
    title: title == null
        ? null
        : Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
    leading: leading == null
        ? null
        : IconButton(
            icon: leading,
            onPressed: () => Get.back(),
            color: Colors.black,
          ),
  );
}

Widget myPasswordTextField(
    {text,
    String? prefixIcon,
    bool suffixIcon = false,
    obscure,
    TextEditingController? controller,
    Function? validator}) {
  AuthController.instance.isObscure.value = obscure;
  return Obx(
    () => SizedBox(
      height: 45,
      child: TextFormField(
        validator: (input) => validator!(input),
        obscureText: AuthController.instance.isObscure.value,
        controller: controller,
        decoration: InputDecoration(
            suffixIcon: suffixIcon
                ? IconButton(
                    onPressed: () {
                      AuthController.instance.toggle();
                    },
                    icon: Icon(
                      AuthController.instance.isObscure.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ))
                : null,
            contentPadding: const EdgeInsets.only(top: 5),
            errorStyle: const TextStyle(fontSize: 0),
            hintStyle: TextStyle(
              color: AppColors.genderTextColor,
            ),
            hintText: text,
            prefixIcon: Image.asset(
              prefixIcon!,
              cacheHeight: 20,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      ),
    ),
  );
}

Widget elevatedButton(
    {required String text, Function? onPress, double fontSize = 18}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(AppColors.blue),
    ),
    onPressed: () {
      onPress!();
    },
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget dropDownWidget(
    {required String valueString,
    required ValueChanged<String?> onChanged,
    listOfEle,
    required String? Function(String?)? validator}) {
  return DropdownButtonFormField<String>(
    isExpanded: true,
    validator: validator,
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
    //borderRadius: BorderRadius.circular(10),
    elevation: 16,
    style: TextStyle(
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    value: valueString,
    onChanged: onChanged,
    items: listOfEle.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xffA6A6A6),
          ),
        ),
      );
    }).toList(),
  );
}
