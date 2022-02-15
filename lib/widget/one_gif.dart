import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/gif.dart';

class OneGif extends StatelessWidget {
<<<<<<< HEAD
  final int? index;
  final GifModel? gif;
  final String? packageId;

  OneGif({Key? key, this.index, this.gif, this.packageId}) : super(key: key);
=======

  final index;
  final GifModel? gif;
  final String? packageId;

  OneGif({Key? key, this.index, this.gif,this.packageId}) : super(key: key);
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721

  @override
  Widget build(BuildContext context) {
    print(packageId);
    return Container(
<<<<<<< HEAD
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.03),
=======
      margin: EdgeInsets.symmetric(vertical: Get.height*0.03),
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: drawerColor),
                    color: whiteColor,
                  ),
                  child: Opacity(
<<<<<<< HEAD
                    opacity: Get.find<DataController>()
                                .myPackages!
                                .contains(packageId) !=
                            true
                        ? 0.001
                        : 1,
                    child: CachedNetworkImage(
                        imageUrl: gif!.gif!,
                        height: Get.height * 0.2,
=======
                    opacity: Get.find<DataController>().myPackages!.contains(packageId) != true ? 0.001 : 1,
                    child: CachedNetworkImage(imageUrl: gif!.gif!,
                        height: Get.height*0.2,
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                        colorBlendMode: BlendMode.modulate),
                  ),
                ),
              ),
              Get.find<DataController>().myPackages!.contains(packageId) != true
                  ? Positioned(
<<<<<<< HEAD
                      top: Get.height * 0.02,
                      right: Get.width * 0.02,
                      child: Image.asset(
                        'assets/icons/lock.png',
                        width: 16,
                      ))
=======
                  top: Get.height * 0.02,
                  right: Get.width * 0.02,
                  child: Image.asset(
                    'assets/icons/lock.png',
                    width: 16,
                  ))
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                  : Container(),
            ],
          ),
          sizedBoxW3,
<<<<<<< HEAD
          Expanded(
              child: AutoSizeText(
                  Get.find<DataController>().myPackages!.contains(packageId) ==
                          true
                      ? gif!.description!
                      : 'Bu hareketi açmanız gerek',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 9)),
=======
          Expanded(child: AutoSizeText(Get.find<DataController>().myPackages!.contains(packageId) == true ? gif!.description! : 'Bu hareketi açmanız gerek',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold) ,maxLines: 9)),
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
        ],
      ),
    );
  }
<<<<<<< HEAD

=======
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
}
