import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class AuthButton extends StatelessWidget {
  final onTap;
  final text;

  AuthButton({Key? key, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.024),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 0.2),
          borderRadius: BorderRadius.circular(35),
          color: mainColor,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
