import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseContainer extends StatelessWidget {
  final image;
  final title;
  final color;
  final textColor;
  final onTap;

  ChooseContainer(
      {Key? key, this.image, this.title, this.color, this.textColor,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.06, horizontal: Get.width * 0.07),
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Image.asset(image),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Text(
                title,
                style: TextStyle(
                    color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
