import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: const AssetImage('assets/logo/Saint_Gobain_Logo.png'),
              width: Get.width * 0.9,
              height: Get.height * 0.34,
            ),
          ),
          SizedBox(
            height: Get.height * 0.08,
          )
        ],
      ),
    );
  }
}
