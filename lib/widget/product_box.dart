import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/ui/drawer_pages/profile/product_basket.dart';

class ProductBox extends StatelessWidget {
  final type;
  final index;
  final ProductModel? oneProduct;
  final UserController? controller1;

  ProductBox(
      {Key? key, this.type, this.index, this.oneProduct, this.controller1});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: productBorderColor,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: oneProduct!.photo!,
            height: Get.height * 0.1,
            fit: BoxFit.cover,
          ),
          sizedBoxW3,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  oneProduct!.title!,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                sizedBox1,
                Text(
                  '₺' +
                      (oneProduct!.discountPrice! *
                              controller1!.productBasket[index].piece!)
                          .toStringAsFixed(2),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                sizedBox1,
                if (type == 'Basket')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller1!.productBasket[index].piece ==
                                  1) {
                                Get.find<UserController>()
                                    .deleteProductFromBasket(
                                        controller1!.productBasket[index].id,controller1!.productBasket[index].discountPrice);
                              } else {
                                Get.find<UserController>().decrease(oneProduct!.id,controller1!.productBasket[index].discountPrice).then((value) {
                                  controller1!.productBasket[index].piece = controller1!.productBasket[index].piece! - 1;
                                  controller1!.productBasket2.refresh();
                                });
                              }
                            },
                            child: Icon(
                              Icons.remove,
                              size: 21,
                            ),
                          ),
                          sizedBoxW3,
                          Obx(() => Text(
                                controller1!.productBasket[index].piece.toString(),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              )),
                          sizedBoxW3,
                          GestureDetector(
                            // increase görevi görüyor burada
                            onTap: () {
                              Get.find<UserController>()
                                  .addToBasket('product', oneProduct!.id,controller1!.productBasket[index].discountPrice)
                                  .then((value) {
                                if (value == 'product') {
                                  controller1!.productBasket[index].piece = controller1!.productBasket[index].piece! + 1;
                                  controller1!.productBasket2.refresh();
                                }
                              });
                            },
                            child: Icon(
                              Icons.add,
                              size: 21,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(onTap: (){
                        Get.dialog(
                          AlertDialog(
                            title: Text(
                              'Silmek istediğinize emin misiniz?',
                            ),
                            actions: [
                              ElevatedButton(onPressed: ()async{
                                var result = await Get.find<UserController>().deleteProductFromBasket(oneProduct!.id,(controller1!.productBasket[index].discountPrice! * controller1!.productBasket[index].piece!));
                                if(result!){
                                  Get.back();
                                  Get.snackbar('Başarılı', 'Ürün başarıyla sepetinizden kaldırıldı');
                                }
                              }, child: Text('Sil'),),
                              ElevatedButton(onPressed: (){
                                Get.back();
                              }, child: Text('Vazgeç'),),
                            ],
                          ),
                        );
                      },child: Image.asset('assets/icons/trash.png')),
                    ],
                  )
                else if (type == 'Order')
                  Row(
                    children: [
                      Image.asset('assets/icons/truck.png'),
                      sizedBoxW1,
                      Text('Kargom Nerede ?'),
                    ],
                  ),
                sizedBox1,
                if (type == 'Order' || type == 'Bought')
                  Row(
                    children: [
                      Image.asset('assets/icons/return.png'),
                      sizedBoxW1,
                      Text('İade'),
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
