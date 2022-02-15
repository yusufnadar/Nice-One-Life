<<<<<<< HEAD
import 'package:auto_size_text/auto_size_text.dart';
=======
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/ui/drawer_pages/products/product_detail.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/prices.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'Ürünler',
        ),
      ),
      body: GetX<DataController>(
          initState: (func) {
            func.controller!.getProducts();
          },
          builder: (_) => GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.07, vertical: Get.height * 0.01),
                itemCount: _.products!.length,
<<<<<<< HEAD
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7),
=======
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.67),
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => Get.to(() => ProductDetail(productId:_.products![index].id)),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.02,
                        horizontal: Get.width * 0.05),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: oneProduct(_.products![index]),
                  ),
                ),
              )),
    );
  }

  Column oneProduct(ProductModel product) {
    return Column(
      children: [
        CachedNetworkImage(imageUrl: product.photo!,width: Get.width*0.2,height: Get.height*0.12,fit: BoxFit.cover,),
        sizedBox2,
<<<<<<< HEAD
        AutoSizeText(product.title!,textAlign: TextAlign.center,maxLines: 1,),
=======
        Text(product.title!,textAlign: TextAlign.center,),
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
        sizedBox2,
        Prices(
          firstPrice: product.discountPrice!.toStringAsFixed(2),
          secondPrice: product.price!.toStringAsFixed(2),
          firstPriceSize: 14,
          secondPriceSize: 12,
        )
      ],
    );
  }
}
