import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/ui/drawer_pages/payment/fill_address.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/product_box.dart';

class ProductBasket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'Ürün Sepetim',
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
          GetX<UserController>(initState: (func) {
            func.controller!.getProductBasket();
        }, builder: (controller1) =>
            ListView.builder(
              padding: EdgeInsets.only(
                  right: Get.width * 0.06,
                  left: Get.width * 0.06,
                  bottom: Get.height * 0.17),
              itemCount: controller1.productBasket.length,
              itemBuilder: (context, index) =>
                  ProductBox(type: 'Basket', index: index,oneProduct:controller1.productBasket[index],controller1: controller1,),
            ),),
        completeShopping(context),
        ],
      ),
    ),);
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
                  StreamBuilder<double>(stream: Get.find<UserController>().getUserBasketPrice('product'),builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return Container();
                    }else{
                      basketPrice = double.parse(snapshot.data!.toStringAsFixed(2));
                      return Text(
                        snapshot.data!.toStringAsFixed(2) + ' ₺',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      );
                    }
                  }),
                ],
              ),
            ),
            AuthButton(
                text: 'Ödemeye Geç',
                onTap: () {
                  if(basketPrice != 0){
                    Get.to(() => FillAddress(basketType: 'product',price: basketPrice,items:Get.find<UserController>().productBasket,));
                  }else{
                    Get.snackbar('Uyarı', 'Sepetiniz Boş');
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
