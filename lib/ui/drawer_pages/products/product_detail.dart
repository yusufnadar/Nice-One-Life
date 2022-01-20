import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/buy_or_add_basket.dart';
import 'package:new_one_life/widget/prices.dart';

class ProductDetail extends StatelessWidget {
  final productId;

  ProductDetail({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<DataController>(initState: (f){
      f.controller!.getProductDetail(productId);
    },builder: (_){
      if(_.product.id == null){
        return Scaffold(body: Center(child: CircularProgressIndicator(),),);
      }else{
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.12),
            child: MyAppBar(
              title: 'Ürün Detayı',
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: CachedNetworkImage(
                          imageUrl: _.product.photo!,
                          width: Get.width,
                        )),
                    sizedBox2,
                    Text(
                      _.product.title!,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: productDetailTitleColor),
                    ),
                    sizedBox2,
                    description(_.product.description!),
                    sizedBox2,
                    Prices(
                      firstPrice: _.product.price!.toStringAsFixed(2),
                      secondPrice: _.product.discountPrice!.toStringAsFixed(2),
                      firstPriceSize: 20,
                      secondPriceSize: 16,
                    ),
                  ],
                ),
              ),
              BuyOrAddBasket(type: 'product',id: _.product.id!,price: _.product.discountPrice,),
            ],
          ),
        );
      }
    });
  }

  Text description(desc) => Text(
      desc,
        style: TextStyle(
            color: productDescriptionColor, fontWeight: FontWeight.w500),
      );
}
