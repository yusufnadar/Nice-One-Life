import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/widget/auth_button.dart';

class PayCompleted extends StatelessWidget {
  const PayCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Image.asset('assets/icons/check.png'),
                    backgroundColor: mainColor,
                    radius: 45,
                  ),
                  sizedBox4,
                  Text(
                    'Siparişiniz Onaylandı',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  sizedBox3,
                  Text(
                    'Siparişiniz başarıyla oluşturuldu. Daha fazla ayrıntı için siparişlerim bölümüne gidin.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.12),
            child: Container(
              margin: EdgeInsets.only(bottom: Get.height*0.02),
              child: AuthButton(
                text: 'Ana Sayfaya Git',
                onTap: () => Get.to(() => HomePage()),
              ),
            ),
          )
        ],
      ),
    );
  }
}
