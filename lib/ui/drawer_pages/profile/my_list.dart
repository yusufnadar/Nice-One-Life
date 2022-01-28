import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/ui/drawer_pages/packages/package_detail.dart';
import 'package:new_one_life/ui/drawer_pages/packages/special_package.dart';
import 'package:new_one_life/widget/app_bar.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.13),
        child: MyAppBar(
          title: 'Listem',
        ),
      ),
      body: GetX<DataController>(init: DataController(),initState: (func){
        func.controller!.getShowMyPackages();
        func.controller!.getMyPackages();
      },builder: (controller) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          itemCount: controller.showMyPackages!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: 0.85),
          itemBuilder: (context, index) => onePackage(controller.showMyPackages![index]),
        );
      },),
    );
  }

  onePackage(PackageModel item) {

    return GestureDetector(
      onTap: () => Get.to(() => PackageDetail(package: item,)),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            CachedNetworkImage(imageUrl: item.photo),
            Positioned.fill(child: Image.asset('assets/photo.png',width: 300,fit: BoxFit.cover,)),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
