import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/ui/drawer_pages/packages/package_detail.dart';
import 'package:new_one_life/ui/drawer_pages/profile/package_basket.dart';

class PackageBox extends StatelessWidget {
  final type;
  final index;
  final PackageModel? onePackage;

  PackageBox({Key? key, this.type, this.index, this.onePackage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2,
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: productBorderColor,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: onePackage!.altPhoto,
            height: Get.height * 0.2,
            width: Get.width*0.2,
            fit: BoxFit.cover,
          ),
          sizedBoxW3,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      onePackage!.title,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: 'Paket Detayları İçin',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16)),
                          TextSpan(
                            text: ' Tıklayın',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(
                                    () => PackageDetail(package: onePackage!));
                              },
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₺' + onePackage!.discountPrice!.toStringAsFixed(2),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    if (type == 'Basket')
                      GestureDetector(
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                title: Text(
                                  'Silmek istediğinize emin misiniz?',
                                ),
                                actions: [
                                  ElevatedButton(onPressed: ()async{
                                    var result = await Get.find<UserController>().deletePackageFromBasket(onePackage!.id,onePackage!.discountPrice);
                                    if(result!){
                                      Get.back();
                                      Get.snackbar('Başarılı', 'Paket başarıyla sepetinizden kaldırıldı');
                                    }
                                  }, child: Text('Sil'),),
                                  ElevatedButton(onPressed: (){
                                    Get.back();
                                  }, child: Text('Vazgeç'),),
                                ],
                              ),
                            );
                          },
                          child: Image.asset('assets/icons/trash.png')),
                    if (type == 'Bought')
                      Row(
                        children: [
                          Image.asset('assets/icons/return.png'),
                          sizedBoxW1,
                          Text('İade'),
                        ],
                      )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
