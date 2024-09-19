import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/style/app_color.dart';
import '../../core/style/styles.dart';
import '../naka_painters/add_ran_painter_screen.dart';
import '../naka_painters/model/ran_painter_model.dart';

class RanPainterScreenCard extends StatelessWidget {
  final RanPainterModel painter;

  const RanPainterScreenCard(this.painter, {super.key});

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
                      painter.painterName!.toUpperCase(),
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
                            AddRanPainterScreen.routeName,
                            arguments: painter,
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.blue,
                          // size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Naka Address:- '), style: subtitleStyle),
                      TextSpan(text: painter.geolocation, style: subtitleStyle2),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Phone number:- '), style: subtitleStyle),
                      TextSpan(
                          text: painter.painterPhone, style: subtitleStyle2),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: ('Giveaway:- '), style: subtitleStyle),
                      TextSpan(text: painter.giveaways, style: subtitleStyle2),
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
