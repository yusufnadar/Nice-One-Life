import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/payment/fill_address.dart';
import 'package:new_one_life/ui/drawer_pages/profile/package_basket.dart';
import 'package:new_one_life/ui/drawer_pages/profile/product_basket.dart';
import 'package:new_one_life/widget/gender_button.dart';

class BuyOrAddBasketController extends GetxController
    with SingleGetTickerProviderMixin {
  AnimationController? animationController;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(vsync: this);
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.back();
        animationController!.reset();
      }
    });
  }
}

class BuyOrAddBasket extends StatelessWidget {
  final type;
  final id;
  final price;

    BuyOrAddBasket({Key? key, this.type, this.id, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BuyOrAddBasketController());
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GenderButton(
              text: 'Sepete Ekle',
              textColor: genderTextColor,
              buttonColor: whiteColor,
              borderColor: genderButtonBorderColor,
              borderWidth: 2.0,
              onTap: () async {
                  var result = await Get.find<UserController>()
                      .addToBasket(type, id,price);
                  if (result == 'package') {
                    await Get.dialog(AlertDialog(content: Lottie.asset(
                      'assets/lottie/check.json',
                      fit: BoxFit.cover,
                      controller: controller.animationController,onLoaded: (composition){
                      controller.animationController!.duration = composition.duration;
                      controller.animationController!.forward();
                    },),),barrierDismissible: false);
                    Get.snackbar('Yönlendirme', 'Paket Sepetine Gitmek İçin Tıklayın',onTap: (a){
                      Get.to(()=>PackageBasket());
                    },duration: Duration(seconds: 2),backgroundColor: Colors.white,colorText: Colors.black);
                  }else if (result == 'product') {
                    await Get.dialog(AlertDialog(content: Lottie.asset(
                      'assets/lottie/check.json',
                      fit: BoxFit.cover,
                      controller: controller.animationController,onLoaded: (composition){
                      controller.animationController!.duration = composition.duration;
                      controller.animationController!.forward();
                    },),),barrierDismissible: false);
                    Get.snackbar('Yönlendirme', 'Ürün Sepetine Gitmek İçin Tıklayın',onTap: (a){
                      Get.to(()=>ProductBasket());
                    },duration: Duration(seconds: 2),backgroundColor: Colors.white,colorText: Colors.black);
                  }
                }
            ),
            sizedBoxW3,
            GenderButton(
                text: 'Satın Al',
                textColor: whiteColor,
                buttonColor: genderButtonColor,
                borderColor: borderColor,
                borderWidth: 0.5,
              onTap: ()=> Get.to(()=>FillAddress(price: price,)),
            ),
          ],
        ),
        color: Colors.white,
        //height: Get.height * 0.08,
        width: Get.width,
      ),
    );
  }
}
