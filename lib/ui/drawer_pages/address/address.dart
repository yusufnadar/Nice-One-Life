import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/address/add_address.dart';
import 'package:new_one_life/widget/app_bar.dart';

class AddressController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController!.dispose();
    super.onClose();
  }
}

class Address extends GetWidget<AddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.17),
        child: MyAppBar(title: 'Adreslerim', isAddress: true),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        child: TabBarView(
          controller: controller.tabController,
          children: [
            address('Teslimat'),
            address('Fatura'),
          ],
        ),
      ),
    );
  }

  address(type) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GetX<UserController>(initState: (func) {
            func.controller!.getAddresses(type);
          }, builder: (_) {
            if (type == 'Teslimat') {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _.deliveryAddress.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.022),
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.02,
                      horizontal: Get.width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: postBorderColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.deliveryAddress[index].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: drawerTitleColor),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  Get.find<UserController>().deleteAddress(
                                      _.deliveryAddress[index].id,type);
                                  break;
                                case 2:
                                  var adres = [];
                                  adres.add(_.deliveryAddress[index].name);
                                  adres.add(_.deliveryAddress[index].surname);
                                  adres.add(_.deliveryAddress[index].city);
                                  adres.add(_.deliveryAddress[index].address);
                                  adres.add(_.deliveryAddress[index].addressName);
                                  adres.add(_.deliveryAddress[index].id);
                                  Get.to(()=>AddAddress(type: 'Teslimat',editAddress: adres,))!.then((value) {
                                    if (value != null) {
                                      Get.snackbar('Başarılı', 'Adres Başarıyla Güncellendi');
                                      Get.find<UserController>().getAddresses(type);
                                    }
                                  });
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: Text('Sil'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text('Düzenle'),
                                value: 2,
                              ),
                            ],
                          )
                        ],
                      ),
                      sizedBox2,
                      Text(
                        _.deliveryAddress[index].address!,
                        style: TextStyle(
                            color: addressColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      sizedBox2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${_.deliveryAddress[index].addressName!} / ',
                            style: TextStyle(
                                fontSize: 13, color: drawerTitleColor),
                          ),
                          Text(
                            _.deliveryAddress[index].city!,
                            style: TextStyle(
                                fontSize: 13, color: drawerTitleColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _.billAddress.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.022),
                  padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.02,
                      horizontal: Get.width * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: postBorderColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _.billAddress[index].name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: drawerTitleColor),
                          ),
                          PopupMenuButton(
                            onSelected: (value) {
                              switch (value) {
                                case 1:
                                  Get.find<UserController>().deleteAddress(
                                      _.billAddress[index].id,type);
                                  break;
                                case 2:
                                  var adres = [];
                                  adres.add(_.billAddress[index].name);
                                  adres.add(_.billAddress[index].surname);
                                  adres.add(_.billAddress[index].city);
                                  adres.add(_.billAddress[index].address);
                                  adres.add(_.billAddress[index].addressName);
                                  adres.add(_.billAddress[index].id);
                                  Get.to(()=>AddAddress(editAddress:adres,type: 'Fatura',))!.then((value) {
                                    if (value != null) {
                                      Get.snackbar('Başarılı', 'Adres Başarıyla Güncellendi');
                                      Get.find<UserController>().getAddresses(type);
                                    }
                                  });
                                  break;
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                child: Text('Sil'),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: Text('Düzenle'),
                                value: 2,
                              ),
                            ],
                          )
                        ],
                      ),
                      sizedBox2,
                      Text(
                        _.billAddress[index].address!,
                        style: TextStyle(
                            color: addressColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      sizedBox2,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${_.billAddress[index].addressName!} / ',
                            style: TextStyle(
                                fontSize: 13, color: drawerTitleColor),
                          ),
                          Text(
                            _.billAddress[index].city!,
                            style: TextStyle(
                                fontSize: 13, color: drawerTitleColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
          sizedBox2,
          GestureDetector(
            onTap: () {
              Get.to(() => AddAddress(type: type))!.then((value) {
                if (value != null) {
                  Get.snackbar('Başarılı', 'Adres Başarıyla Eklendi');
                  Get.find<UserController>().getAddresses(type);
                }
              });
            },
            child: FDottedLine(
              color: dotBorderColor,
              width: Get.width,
              strokeWidth: 1.0,
              dottedLength: 6.0,
              space: 3,
              corner: FDottedLineCorner(
                  leftBottomCorner: 8,
                  leftTopCorner: 8,
                  rightBottomCorner: 8,
                  rightTopCorner: 8),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: mainColor),
                    sizedBoxW3,
                    Text(
                      '$type Adresi Ekle',
                      style: TextStyle(
                          fontSize: 16,
                          color: mainColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          sizedBox2,
        ],
      ),
    );
  }
}
