import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/buy_or_add_basket.dart';
import 'package:new_one_life/widget/one_gif.dart';
import 'package:new_one_life/widget/prices.dart';

class PackageDetail extends StatelessWidget {
  final PackageModel? package;

  PackageDetail({Key? key, this.package});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: package!.title,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: package!.altPhoto,
                ),
                sizedBox2,
                Text(
                  package!.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                sizedBox1,
                Prices(
                  firstPrice:
                      package!.discountPrice!.toStringAsFixed(2) + ' TL',
                  secondPrice: package!.price!.toStringAsFixed(2) + ' TL',
                  firstPriceSize: 18.0,
                  secondPriceSize: 16.0,
                ),
                sizedBox22,
                description(),
                sizedBox22,
                GetX<DataController>(
                    initState: (func) {
                      func.controller!.getGifs(package!.id);
                    },
                    builder: (_) => ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: Get.height * 0.08),
                          itemCount: _.gifs!.length,
                          itemBuilder: (context, index) => OneGif(
                            index: index,
                            gif: _.gifs![index],
                            packageId:package!.id
                          ),
                        ))
              ],
            ),
          ),
          BuyOrAddBasket(
            type: 'package',
            id: package!.id,
            price:package!.discountPrice
          ),
        ],
      ),
    );
  }

  Text description() {
    return Text(
      package!.description,
      style: TextStyle(
          color: productDescriptionColor,
          fontSize: 15,
          fontWeight: FontWeight.w500),
    );
  }
}
