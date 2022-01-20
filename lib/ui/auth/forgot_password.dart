import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/auth_text.dart';
import 'package:new_one_life/widget/back_button.dart';
import 'package:new_one_life/widget/close_keyboard.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CloseKeyboard(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Column(
            children: [
              sizedBox10,
              MyBackButton(),
              CircleAvatar(
                backgroundColor: Color(0xffD3E1FC),
                radius: 70,
              ),
              sizedBox7,
              Text(
                'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              sizedBox8,
              AuthText(
                hintText: 'Email',
              ),
              sizedBox3,
              AuthButton(
                text: 'Şifreyi Sıfırla',
              ),
              sizedBox3,
            ],
          ),
        ),
      ),
    );
  }
}
