import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.03,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset(
                'assets/icons/back-button.png',
                width: 30,
                color: backButtonColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
