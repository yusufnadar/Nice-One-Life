import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class AuthText extends StatelessWidget {
  final hintText;
  final controller;
  final keyboardType;
  final validator;
  final obscureText;
  final suffixIcon;
  final initialValue;

  AuthText({Key? key, this.hintText, this.controller, this.keyboardType, this.validator,this.obscureText,this.suffixIcon, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      initialValue: initialValue,
      obscureText: obscureText != null ? obscureText : false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: Get.height*0.02,horizontal: Get.width*0.04),
        labelStyle: TextStyle(color: hintTextColor, fontSize: 13),
        labelText: hintText,
        fillColor: textFormBackgroundColor,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: textBorderColor),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textBorderColor),
            borderRadius: BorderRadius.circular(10)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textBorderColor),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}
