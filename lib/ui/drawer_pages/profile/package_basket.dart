import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/ui/drawer_pages/payment/fill_address.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/package_box.dart';

class PackageBasket extends StatelessWidget {

  var packageList = <PackageModel>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'Paket Sepetim',
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GetX<UserController>(
                init: UserController(),
                initState: (func) {
                  func.controller!.getPackageBasket();
                },
                builder: (controller1) {
                  return ListView.builder(
                    padding: EdgeInsets.only(
                      right: Get.width * 0.06,
                      left: Get.width * 0.06,
                      bottom: Get.height * 0.17,),
                    itemCount: controller1.packageBasket.length,
                    itemBuilder: (context, index) {
                      return PackageBox(
                        type: 'Basket',
                        index: index,
                        onePackage: controller1.packageBasket[index],);
                    },
                  );
                }),
            completeShopping(context),
          ],
        ),
      ),
    );
  }


  var basketPrice = 0.0;

  Positioned completeShopping(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.white,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: Get.height * 0.02, top: Get.height * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Toplam Fiyat',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  StreamBuilder<double>(
                      stream: Get.find<UserController>().getUserBasketPrice(
                          'package'), builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    } else {
                      basketPrice =
                          double.parse(snapshot.data!.toStringAsFixed(2));
                      return Text(
                        snapshot.data!.toStringAsFixed(2) + ' ???',
                        style: TextStyle(fontSize: 20,
                            fontWeight: FontWeight.w600),
                      );
                    }
                  })
                ],
              ),
            ),
            AuthButton(
                text: '??demeye Ge??',
                onTap: () {
                  if (basketPrice != 0) {
                    Get.to(() =>
                        FillAddress(
                            basketType: 'package', price: basketPrice, items:Get.find<UserController>().packageBasket));
                  } else {
                    Get.snackbar('Uyar??', 'Sepetiniz Bo??');
                  }
                }
            ),
            sizedBox2
          ],
        ),
      ),
    );
  }
}
