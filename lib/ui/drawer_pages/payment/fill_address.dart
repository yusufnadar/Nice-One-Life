import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/address.dart';
import 'package:new_one_life/ui/drawer_pages/address/add_address.dart';
import 'package:new_one_life/ui/drawer_pages/payment/pay.dart';
import 'package:new_one_life/widget/app_bar.dart';

class FillAddressController extends GetxController{

  RxnInt _deliveryIndex = RxnInt();
  get deliveryIndex => _deliveryIndex.value;
  set setDeliveryIndex(var value)=> _deliveryIndex.value = value;

  RxnInt _billIndex = RxnInt();
  get billIndex => _billIndex.value;
  set setBillIndex(var value)=> _billIndex.value = value;

  RxString _name = ''.obs;
  get name => _name.value;
  set setName(var value)=> _name.value = value;

  RxBool _sameAddress = false.obs;
  get sameAddress => _sameAddress.value;
  set setSameAddress(var value)=> _sameAddress.value = value;

}

class FillAddress extends GetWidget<FillAddressController> {

  final double? price;
  final basketType;
  final items;

<<<<<<< HEAD
  FillAddress({Key? key,this.price,this.basketType,this.items}) : super(key: key);
=======
  FillAddress({Key? key,this.price,this.basketType,this.items});
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: 'Ödeme Sayfası',
        ),
      ),
      body: Obx(()=>Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: Get.height * 0.01),
            child: Column(
              children: [
                firstAddressTitle(),
                firstAddresses(),
                controller.sameAddress == false ? secondAddressTitle() : Container(),
                controller.sameAddress == false ? secondAddresses() : Container(),
                sizedBox2,
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Alıcı Adı:    ',
                            style: TextStyle(
                                color: takenNameColor,
                                fontWeight: FontWeight.bold),
                          ),
                          /*
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01),
                              child: Text(
                                'KDV:    ',
                                style: TextStyle(
                                    color: takenNameColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          Text('Kargo Ücreti:    ',
                              style: TextStyle(
                                  color: takenNameColor,
                                  fontWeight: FontWeight.bold),),
                           */
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.name,
                            style: TextStyle(fontWeight: FontWeight.bold,color: addressTitleColor),
                          ),
                          /*
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.01),
                            child: Text('19.08 TL',
                                style: TextStyle(fontWeight: FontWeight.bold,color: addressTitleColor)),
                          ),
                          Text(
                            '15.45 TL',
                            style: TextStyle(fontWeight: FontWeight.bold,color: addressTitleColor),
                          )
                           */
                        ],
                      ),
                    ),
                  ],
                ),
                sendSameAddress(),
              ],
            ),
          ),
          payButton(),
        ],
      )),
    );
  }

  Container firstAddressTitle() {
    return Container(
      margin: EdgeInsets.only(
        right: Get.width * 0.06,
        left: Get.width * 0.06,
        bottom: Get.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Teslimat Adresi',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: addressTitleColor),
          ),
          GestureDetector(
            onTap: () {
              Get.to(()=>AddAddress(type: 'Teslimat',))!.then((value) {
                if (value != null) {
                  Get.snackbar('Başarılı', 'Adres Başarıyla Eklendi');
                  Get.find<UserController>().getAddresses('Teslimat');
                }else{
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              }).then((value) {
              });
            },
            child: Row(
              children: [
                Icon(Icons.add),
                Text(
                  'Adres Ekle',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: addressTitleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var texti =
      'İstanbul beşiktaş nehir caddesi no:2 d:1dfsdsf dfsddsfdsfdsffdsdfdfsdsfssfd  dsf sdffd dfsdf dsd9 İstanbul beşiktaş nehir caddesi no:2 d:19';
/*

 */
  firstAddresses() {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      height: Get.height*0.21,
      child: GetX<UserController>(dispose: (func){
        SchedulerBinding.instance!.addPostFrameCallback((_){
          controller.setDeliveryIndex = null;
          controller.setBillIndex = null;
          controller.setName = '';
          controller.setSameAddress = false;
        });
      },initState: (func){
        func.controller!.getAddresses('Teslimat');
      },builder: (_)=>Container(
        alignment: Alignment.centerLeft,
        child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: _.deliveryAddress.length,itemBuilder: (context,index)=>GestureDetector(
          onTap: () {
            controller.setDeliveryIndex = index;
            controller.setName = _.deliveryAddress[index].name! + _.deliveryAddress[index].surname!;
            deliveryAddress = _.deliveryAddress[index];
          },
          child: Container(
            height: Get.height * 0.21,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.02),
            margin: EdgeInsets.only(
                right: Get.width * 0.03,
                left: index == 0 ? Get.width * 0.06 : 0),
            decoration: BoxDecoration(
              color:
              controller.deliveryIndex == index ? fillAddressColor : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
                color: controller.deliveryIndex != index
                    ? emptyAddressBorderColor
                    : Colors.transparent,
              ),
            ),
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.01),
                  child: Text(
                    _.deliveryAddress[index].addressName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: addressTitleColor,
                    ),
                  ),
                ),
                Text(
                  _.deliveryAddress[index].address!.length > 100
                      ? _.deliveryAddress[index].address!.substring(0, 100) + '...'
                      : _.deliveryAddress[index].address!,
                  style: TextStyle(
                    fontSize: 12,
                    color: addressColor,
                  ),
                ),
              ],
            ),
          ),
        ),),
      )),
    );
  }

  Container secondAddressTitle() {
    return Container(
      margin: EdgeInsets.only(
        right: Get.width * 0.06,
        left: Get.width * 0.06,
        bottom: Get.height * 0.02,
        top: Get.height * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fatura Adresi',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: addressTitleColor),
          ),
          GestureDetector(
            onTap: () {
              Get.to(()=>AddAddress(type: 'Fatura'))!.then((value) {
                if (value != null) {
                  Get.snackbar('Başarılı', 'Adres Başarıyla Eklendi');
                  Get.find<UserController>().getAddresses('Fatura');
                }else{
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                }
              });
            },
            child: Row(
              children: [
                Icon(Icons.add),
                Text(
                  'Adres Ekle',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: addressTitleColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AddressModel? billAddress;
  AddressModel? deliveryAddress;

  Container secondAddresses() {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height * 0.02),
      height: Get.height*0.21,
      child: GetX<UserController>(initState: (func){
          func.controller!.getAddresses('Fatura');
      },builder: (_)=>Container(
        alignment: Alignment.centerLeft,
        child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,itemCount: _.billAddress.length,itemBuilder: (context,index)=>GestureDetector(
          onTap: () {
            controller.setBillIndex = index;
            _.billAddress2.refresh();
            billAddress = _.billAddress[index];
          },
          child: Container(
            height: Get.height * 0.21,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04,
                vertical: Get.height * 0.02),
            margin: EdgeInsets.only(
                right: Get.width * 0.03,
                left: index == 0 ? Get.width * 0.06 : 0),
            decoration: BoxDecoration(
              color:
              controller.billIndex == index ? fillAddressColor : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 1,
                color: controller.billIndex != index
                    ? emptyAddressBorderColor
                    : Colors.transparent,
              ),
            ),
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.01),
                  child: Text(
                    _.billAddress[index].addressName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: addressTitleColor,
                    ),
                  ),
                ),
                Text(
                  _.billAddress[index].address!.length > 100
                      ? _.billAddress[index].address!.substring(0, 100) + '...'
                      : _.billAddress[index].address!,
                  style: TextStyle(
                    fontSize: 12,
                    color: addressColor,
                  ),
                ),
              ],
            ),
          ),
        ),),
      ),),
    );
  }

  Container kdv() {
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.06, top: Get.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
        children: const [
=======
        children: [
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
          Text('KDV: '),
          Text(
            '19.08 TL',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Container shippingFee() {
    return Container(
      margin: EdgeInsets.only(left: Get.width * 0.06, top: Get.height * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
        children: const [
=======
        children: [
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
          Text('Kargo Ücreti: '),
          Text(
            '15.45 TL',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Positioned payButton() {
    return Positioned(
      bottom: 0,
      child: Container(
        height: Get.height * 0.1,
        decoration: BoxDecoration(color: postBorderColor),
        padding: EdgeInsets.only(right: Get.width * 0.06,left: Get.width*0.1),
        width: Get.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ödenecek Tutar',
                  style: TextStyle(
                    color: addressTitleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: Get.height * 0.01),
                  child: Text(
                    price!.toStringAsFixed(2)+' ₺',
                    style: TextStyle(
                      color: addressTitleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (controller.deliveryIndex != null &&
                    (controller.billIndex != null || controller.sameAddress == true)) {
                  Get.to(() => Pay(basketType:basketType,price:price,address:[deliveryAddress!,billAddress!],items:items));
                }else{
                  Get.snackbar('Uyarı', 'Lütfen Adres Bilgilerini Seçin');
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04,vertical: Get.height*0.02),
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(20),
                ),
<<<<<<< HEAD
                child: const Text(
=======
                child: Text(
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                  'Ödemeye Geç',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  CheckboxListTile sendSameAddress() {
    return CheckboxListTile(
        dense: false,
        contentPadding: EdgeInsets.only(left: Get.width*0.1,right: Get.width * 0.06,),
        title: Text(
          'Faturayı aynı teslimat adresine gönder',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: takenNameColor),
        ),
        value: controller.sameAddress,
        onChanged: (value) {
          controller.setSameAddress = value!;
        });
  }
}
