import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/auth/login.dart';
import 'package:new_one_life/widget/back_button.dart';
import 'package:new_one_life/widget/choose_container.dart';

class Choose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Column(
          children: [
            sizedBox10,
            MyBackButton(),
            CircleAvatar(
              backgroundColor: Color(0xffD3E1FC),
              radius: 70,
            ),
            sizedBox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChooseContainer(
                  onTap: () {
                    Get.to(() => Login(isDoctor: false));
                  },
                  image: 'assets/icons/heart.png',
                  title: 'Hasta Girişi',
                  color: mainColor,
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                ChooseContainer(
                  onTap: () {
                    Get.to(() => Login(isDoctor: true));
                  },
                  image: 'assets/icons/stethoscope.png',
                  title: 'Doktor Girişi',
                  color: chooseContainerColor,
                  textColor: chooseTextColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
