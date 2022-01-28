import 'package:flutter/material.dart';
import 'package:new_one_life/default/colors.dart';

class PostText extends StatelessWidget {
  final controller;
  final validator;
  PostText({Key? key, this.controller,this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 7,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        fillColor: whiteColor,
        filled: true,
        hintText: 'Yorum Yazınız',
        hintStyle: TextStyle(color: postHintTextColor,fontSize: 14,fontWeight: FontWeight.w700),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
        disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: postBorderColor)),
      ),
    );
  }
}
