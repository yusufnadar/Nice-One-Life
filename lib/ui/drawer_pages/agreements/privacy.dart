import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/widget/app_bar.dart';


class PrivacyController extends GetxController{

  RxString _privacy = ''.obs;
  get privacy => _privacy.value;
  set setPrivacy(String value) => _privacy.value = value;

}


class Privacy extends GetWidget<PrivacyController> {
  const Privacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: 'Gizlilik Sözleşmesi',
          isHomePage: false,
        ),
      ),
      body: GetX<DataController>(initState: (_){
        _.controller!.getPrivacyPolicy();
      },builder: (_)=>Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.07),
        child: Text(controller.privacy),
      )),
    );
  }
}
