import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/protein_value.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/loading_screen.dart';

class ProteinsController extends GetxController {
  RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set setisLoading(bool value) => _isLoading.value = value;
}

class Proteins extends GetWidget<ProteinsController> {
  const Proteins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.13),
        child: MyAppBar(
          title: 'Protein Değerleri',
        ),
      ),
      body: GetX<DataController>(
        init: DataController(),
        initState: (func) {
          func.controller!.getProteinValues();
        },
        builder: (_) {
          if (controller.isLoading) {
            return LoadingScreen();
          } else {
            if (_.proteinValues!.isEmpty) {
              return Center(
                child: Text('Henüz Ürün Yok'),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08),
                itemCount: _.proteinValues!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.53,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20),
                itemBuilder: (context, index) =>
                    oneProduct(index, _.proteinValues!),
              );
            }
          }
        },
      ),
    );
  }

  oneProduct(int index, List<ProteinValueModel> proteinValues) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: proteinValues[0].photo!,
          ),
          sizedBox1,
          AutoSizeText(
            proteinValues[0].title!,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: proteinTitleColor,
            ),
            maxLines: 2,
            minFontSize: 11,
            maxFontSize: 12,
          ),
          AutoSizeText(
            proteinValues[0].piece!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            maxLines: 2,
            minFontSize: 10,
            maxFontSize: 11,
          ),
          AutoSizeText(
            proteinValues[0].protein! + ' Gr Protein',
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            minFontSize: 10,
            maxFontSize: 11,
          ),
        ],
      ),
    );
  }
}
