import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/ui/drawer_pages/packages/package_detail.dart';
import 'package:new_one_life/widget/app_bar.dart';

class Packages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.13),
        child: MyAppBar(
          title: 'Paketler',
          isHomePage: false,
        ),
      ),
      body: GetX<DataController>(initState: (func){
        func.controller!.getPackages();
        func.controller!.getMyPackages();
      },builder: (_)=>GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        itemCount: _.packages!.length,
<<<<<<< HEAD
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
=======
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
            crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: 0.85),
        itemBuilder: (context, index) => onePackage(index,_.packages![index]),
      )),
    );
  }

  onePackage(int index, PackageModel package) {
<<<<<<< HEAD
=======
    var liste = ['Diyet', 'Zayıflatma', 'Kas', 'Güç', 'Fit', 'Kilo Alma'];
    var listePhoto = [
      'assets/diyet.png',
      'assets/zayiflatma.png',
      'assets/kas.png',
      'assets/guc.png',
      'assets/fit.png',
      'assets/kilo.png'
    ];
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
    return GestureDetector(
      onTap: () => Get.to(() => PackageDetail(package: package,)),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(16),child: CachedNetworkImage(imageUrl: package.photo,height: Get.height,fit: BoxFit.cover,)),//Image.asset(listePhoto[index]),
            Positioned.fill(child: ClipRRect(borderRadius: BorderRadius.circular(16),child: Image.asset('assets/photo.png',fit: BoxFit.cover))),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  package.title,
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
