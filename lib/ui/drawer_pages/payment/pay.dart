import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/address.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PayController extends GetxController {
  RxString _cardNumber = ''.obs;

  String get cardNumber => _cardNumber.value;

  set setCardNumber(String value) => _cardNumber.value = value;

  final RxString _expiryDate = ''.obs;

  String get expiryDate => _expiryDate.value;

  set setExpiryDate(String value) => _expiryDate.value = value;

  final RxString _cardHolderName = ''.obs;

  String get cardHolderName => _cardHolderName.value;

  set setCardHolderName(String value) => _cardHolderName.value = value;

  final RxString _cvvCode = ''.obs;

  String get cvvCode => _cvvCode.value;

  set setCvvCode(String value) => _cvvCode.value = value;

  final RxBool _isCvvFocused = false.obs;

  bool get isCvvFocused => _isCvvFocused.value;

  set setIsCvvFocused(bool value) => _isCvvFocused.value = value;
}

class Pay extends GetWidget<PayController> {
  final basketType;
  final price;
  final List<AddressModel>? address;
  final List? items;

  Pay({Key? key, this.basketType,this.price,this.address,this.items});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: 'Ödeme Sayfası',
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() => Column(
              children: [
                CreditCardWidget(
                  cardBgColor: mainColor,
                  cardNumber: controller.cardNumber,
                  expiryDate: controller.expiryDate,
                  cardHolderName: controller.cardHolderName,
                  cvvCode: controller.cvvCode,
                  showBackView: controller.isCvvFocused,
                  onCreditCardWidgetChange: (var a) {},
                ),
                CreditCardForm(
                  formKey: formKey,
                  // Required
                  onCreditCardModelChange: (CreditCardModel data) {
                    controller.setCardNumber = data.cardNumber;
                    controller.setExpiryDate = data.expiryDate;
                    controller.setCardHolderName = data.cardHolderName;
                    controller.setCvvCode = data.cvvCode;
                    controller.setIsCvvFocused = data.isCvvFocused;
                  },
                  // Required
                  themeColor: Colors.red,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                  cardHolderName: 'yusuy',
                  cvvCode: '123',
                  expiryDate: '123',
                  cardNumber: '123',
                ),
                sizedBox10,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: AuthButton(
                    text: 'Ödemeyi Tamamla',
                    onTap: () async {
                      var uid = const Uuid().v4();
                      var liste = <Map<String,dynamic>>[];
                      if(basketType == 'package'){
                        for(var item in items!){
                          liste.add({
                            "id": item.id,
                            "name": item.title,
                            "category1": "Kategori Yok",
                            "price": item.discountPrice
                          });
                        }
                      }else{
                        for(var item in items!){
                          liste.add({
                            "id": item.id,
                            "name": item.title,
                            "category1": "Kategori Yok",
                            "price": item.discountPrice,
                            "piece":item.piece
                          });
                        }
                      }
                      var msg = {
                        "price":price,
                        "basketId":uid,
                        "cardHolderName":controller.cardHolderName,
                        "cardNumber":controller.cardNumber.replaceAll(" ", ""),
                        "expireMonth":controller.expiryDate.substring(0,2),
                        "expireYear":"20${controller.expiryDate.substring(3,5)}",
                        "cvc":controller.cvvCode,
                        "registerCard":"0",
                        "id":Get.find<UserController>().user.id,
                        "name":address![0].name,
                        "surname":address![0].surname,
                        "gsmNumber":address![0].phoneNumber,
                        "email":Get.find<UserController>().user.email,
                        "registrationAddress":address![0].addressName,
                        "city":address![0].city,
                        "scontactName":'${address![0].name} ${address![0].surname}',
                        "scity":address![0].city,
                        "saddress":address![0].address,
                        "bcontactName":'${address![1].name} ${address![1].surname}',
                        "bcity":address![1].city,
                        "baddress":address![1].address,
                        "basketItems":liste
                      };
                      var response = await http.post(Uri.parse('http://10.0.2.2:8080/get'),body: json.encode(msg),headers: {'Content-Type':'application/json'});
                      if(response.statusCode == 200){
                        if(basketType == 'package'){
                          var sonuc = await Get.find<UserController>().finishPay(liste);
                          if(sonuc){
                            Get.offAll(()=>HomePage());
                          }else{
                            Get.snackbar('Hata', 'Ödeme alındı fakat işlem gerçekleşmedi, lütfen bizi arayın');
                          }
                        }else{
                          var sonuc = await Get.find<UserController>().finishPay2(liste);
                          if(sonuc){
                            Get.offAll(()=>HomePage());
                          }else{
                            Get.snackbar('Hata', 'Ödeme alındı fakat işlem gerçekleşmedi, lütfen bizi arayın');
                          }
                        }
                        //Get.to(() => PayCompleted());
                      }
                    }
                  ),
                ),
                sizedBox3
              ],
            )),
      ),
    );
  }
}
