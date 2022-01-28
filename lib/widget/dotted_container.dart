import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
class DottedContainer extends StatelessWidget {
  final imageOrIcon;
  final text;

  DottedContainer({Key? key, this.imageOrIcon, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      FDottedLine(
        color: dotBorderColor,
        width: Get.width,
        strokeWidth: 1.0,
        dottedLength: 6.0,
        space: 3,
        corner: FDottedLineCorner(leftBottomCorner: 8,leftTopCorner: 8,rightBottomCorner: 8,rightTopCorner: 8),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height*0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageOrIcon,
              sizedBoxW3,
              Text(text,style: TextStyle(fontSize: 16,color: mainColor,fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      );

  }
}

