import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class GenderButton extends StatelessWidget {
  final text;
  final textColor;
  final buttonColor;
  final borderColor;
  final borderWidth;
  final onTap;

  GenderButton({Key? key, this.text, this.textColor, this.buttonColor, this.borderColor, this.borderWidth, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: Get.height*0.016,horizontal: Get.width*0.08),
          child: Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: buttonColor,border: Border.all(color: borderColor,width: borderWidth)),
        ),
      ),
    );
  }
}
