import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/style/app_color.dart';
import '../../core/style/styles.dart';
import '../retail_outlet/add_retail_outlet_screen.dart';
import '../retail_outlet/model/retail_outlet_model.dart';

class RetailOutletScreenCard extends StatelessWidget {
  final RetailOutletModel outlet;

  const RetailOutletScreenCard(this.outlet, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            spreadRadius: 0.1,
            offset: Offset(0, 10),
          )
        ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
        padding:
            const EdgeInsets.only(bottom: 25, top: 10, right: 20, left: 20),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      outlet.outletName!.toUpperCase(),
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(
                            AddRetailOutletScreen.routeName,
                            arguments: outlet,
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          // size: 35,
                        ),
                      ),
                    ),
                    /*Obx(
                      () => Container(
                        alignment: Alignment.topRight,
                        child: CustomerController.instance.isEditLoading.value
                            ? const CircularProgressIndicator()
                            : IconButton(
                                onPressed: () {
                                  CustomerController.instance
                                      .deleteCustomer(student);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.blue,
                                  // size: 35,
                                ),
                              ),
                      ),
                    ),*/
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Outlet Owner Name:- '), style: subtitleStyle),
                      TextSpan(
                          text: (outlet.outletOwner), style: subtitleStyle2),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Outlet address:- '), style: subtitleStyle),
                      TextSpan(text: outlet.outletAddress, style: subtitleStyle2),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Phone number:- '), style: subtitleStyle),
                      TextSpan(
                          text: outlet.outletPhone.toString(), style: subtitleStyle2),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Giveaway:- '), style: subtitleStyle),
                      TextSpan(text: outlet.giveaways, style: subtitleStyle2),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
