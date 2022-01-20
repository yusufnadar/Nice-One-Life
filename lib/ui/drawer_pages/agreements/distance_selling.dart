import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/widget/app_bar.dart';


class DistanceCellingController extends GetxController{

  RxString _distanceSelling = ''.obs;
  get distanceSelling => _distanceSelling.value;
  set setDistanceSelling(String value) => _distanceSelling.value = value;

}


class DistanceSelling extends GetWidget<DistanceCellingController> {
  const DistanceSelling({Key? key}) : super(key: key);

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
        _.controller!.getDistanceSelling();
      },builder: (_)=>Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.07),
        child: Text(controller.distanceSelling),
      )),
    );
  }
}
