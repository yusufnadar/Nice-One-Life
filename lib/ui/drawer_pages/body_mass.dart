import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/auth_text.dart';

class BodyMassController extends GetxController{

  RxDouble _result = 0.0.obs;
  get result => _result.value;
  set setResult(double value)=> _result.value = value;

  RxString _resultText = ''.obs;
  get resultText => _resultText.value;
  set setResultText(String value)=> _resultText.value = value;

  var _valueColor = Colors.grey.obs;
  get valueColor => _valueColor.value;
  set setvalueColor(MaterialColor value)=> _valueColor.value = value;
}

class BodyMass extends GetWidget<BodyMassController> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.13),
        child: MyAppBar(
          title: 'Vücut Kitle İndeksi',
          isHomePage: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
        child: GetX(init: BodyMassController(),dispose: (f){
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            controller.setResultText = '';
            controller.setResult = 0.0;
            controller.setvalueColor = Colors.grey;
            weightController.clear();
            heightController.clear();
          });

        },builder: (_){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kilonuzu Yazınız', style: TextStyle(color: drawerTitleColor)),
              sizedBox1,
              AuthText(
                controller: weightController,
                keyboardType: TextInputType.number,
              ),
              sizedBox3,
              Text('Boyunuzu Yazınız  (cm cinsinden)', style: TextStyle(color: drawerTitleColor)),
              sizedBox1,
              AuthText(
                controller: heightController,
                keyboardType: TextInputType.number,
              ),
              sizedBox4,
              AuthButton(
                text: 'Hesapla',
                onTap: () {
                  calculateBodyMass();
                },
              ),
              sizedBox4,
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                    color: bodyMassContainerColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    sizedBox22,
                    Text(
                      'Sonuç',
                      style: TextStyle(
                          color: hintTextColor, fontWeight: FontWeight.bold),
                    ),
                    sizedBox22,
                    Text(
                      controller.result.toString(),
                      style: TextStyle(
                          color: hintTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: Get.width * 0.5,
                        child: Slider(
                          min: 0,
                          max: 40,
                          value: controller.result,
                          onChanged: (value) {},
                          activeColor: controller.valueColor,
                        )),
                    Text(
                      controller.resultText,
                      style: TextStyle(
                          color: hintTextColor, fontWeight: FontWeight.bold),
                    ),
                    sizedBox3,
                  ],
                ),
              ),

              sizedBox22
            ],
          );
        }),
      ),
    );
  }

  void calculateBodyMass() {
      var square = (int.parse(heightController.text) / 100) *
          (int.parse(heightController.text) / 100);
      controller.setResult = double.parse(
          (int.parse(weightController.text) / square).toStringAsFixed(2));
      if (controller.result < 18.5) {
        controller.setResultText = 'Zayıf';
        controller.setvalueColor = Colors.yellow;
      } else if (controller.result >= 18.5 && controller.result! < 24.9) {
        controller.setResultText = 'Normal Kilolu';
        controller.setvalueColor = Colors.green;
      } else if (controller.result >= 25 && controller.result < 29.9) {
        controller.setResultText = 'Fazla Kilolu';
        controller.setvalueColor = Colors.orange;
      } else if (controller.result >= 30 && controller.result < 39.9) {
        controller.setResultText = 'Obez';
        controller.setvalueColor = Colors.red;
      } else if (controller.result! > 40) {
        controller.setResultText = 'İleri Derecede Obez';
        controller.setvalueColor = Colors.brown;

      }
  }

}
