import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';
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
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        itemCount: 2,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: 0.85),
        itemBuilder: (context, index) => onePackage(index),
      ),
    );
  }

  onePackage(int index) {
    var liste = ['Diyet', 'Zayıflatma', 'Kas', 'Güç', 'Fit', 'Kilo Alma'];
    var listePhoto = [
      'assets/diyet.png',
      'assets/zayiflatma.png',
      'assets/kas.png',
      'assets/guc.png',
      'assets/fit.png',
      'assets/kilo.png'
    ];
    return GestureDetector(
      onTap: () => index != 0
          ? Get.to(() => PackageDetail())
          : Get.to(() => SpecialPackage()),
      child: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image.asset(listePhoto[index]),
            Image.asset('assets/photo.png'),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  index != 0 ? liste[index] : 'Ameliyat Sonrası',
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
