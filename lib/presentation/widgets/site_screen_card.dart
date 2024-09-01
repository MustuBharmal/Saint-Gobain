import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/style/app_color.dart';
import '../site/add_site_screen.dart';
import '../site/model/site_model.dart';

class SiteScreenCard extends StatelessWidget {
  final SiteModel site;

  const SiteScreenCard(this.site, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: InkWell(
        onTap: () {
        },
        child: Container(
          width: (Get.width),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              spreadRadius: 0.1,
              offset: Offset(0, 10),
            )
          ], color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.only(bottom: 25, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      site.contractorName!.capitalize!,
                      overflow: TextOverflow.visible,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(
                          AddSiteScreen.routeName,
                          arguments: site,
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        // size: 35,
                      ),
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.topRight,
                  //   child: OutletController.instance.isEditLoading.value
                  //       ? const CircularProgressIndicator()
                  //       : IconButton(
                  //           onPressed: () {
                  //             OutletController.instance.deleteOutlet(outlet);
                  //           },
                  //           icon: const Icon(
                  //             Icons.delete,
                  //             color: Colors.blue,
                  //             // size: 35,
                  //           ),
                  //         ),
                  // ),
                ],
              ),
              /*Text(
                  "Owner name:- ${outlet.ownerName}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Owner city name:- ${outlet.cityName}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Owner area name:- ${outlet.areaName}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Owner email:- ${outlet.ownerEmail}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                */
              Text(
                'Address:- ${site.siteAddress}, ${site.cityName}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                'Added by:- ${site.createdBy!.capitalizeFirst}',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              /*Row(
                children: [
                  if (college.listOfImages != null)
                      CircleAvatar(
                        foregroundImage: NetworkImage(outlet.imagePath1!),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (outlet.imagePath2 != null)
                      CircleAvatar(
                        foregroundImage: NetworkImage(outlet.imagePath2!),
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (outlet.imagePath3 != null)
                      CircleAvatar(
                        foregroundImage: NetworkImage(outlet.imagePath3!),
                      )
                ],
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
