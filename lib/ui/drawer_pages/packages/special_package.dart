import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/packages/package_detail.dart';
import 'package:new_one_life/widget/app_bar.dart';

class SpecialPackage extends StatelessWidget {


  var liste = ['1.Ay', '2.Ay', '3.Ay', '4.Ay', '5.Ay', '6.Ay'];
  var listePhoto = [
    'assets/diyet.png',
    'assets/zayiflatma.png',
    'assets/kas.png',
    'assets/guc.png',
    'assets/fit.png',
    'assets/kilo.png'
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: 'Ameliyat Sonrası',
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: 0.85),
        itemBuilder: (context, index) => onePackage(index),
      ),
    );
  }

  onePackage(int index) {
    return GestureDetector(
      onTap: () => Get.to(() => PackageDetail()),
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
                  liste[index],
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (index != 0) Positioned(right: 10,top: 10,child: Image.asset('assets/icons/lock.png',color: Colors.red,)) else Positioned.fill(child: Container())
          ],
        ),
      ),
    );
  }

}
