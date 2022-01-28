import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class PageViewInformations extends StatefulWidget {
  final String? title;
  final String? description;
  final String? photo;

  PageViewInformations(
      {this.title,
      this.description,
      this.photo,});

  @override
  _PageViewInformationsState createState() => _PageViewInformationsState();
}

class _PageViewInformationsState extends State<PageViewInformations> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Column(
        children: [
          photoPart(context),
          Column(
            children: [
              titlePart(context),
              descriptionPart(context),
            ],
          ),
        ],
      ),
    );
  }

  Container photoPart(context) {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.15),
      child: CircleAvatar(
        backgroundColor: mainColor,
        radius: 80,
      ),
    );
  }

  Container titlePart(context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: Get.height * 0.04, top: Get.height * 0.08),
      child: Text(
        widget.title!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: pageViewTitleColor),
      ),
    );
  }

  Text descriptionPart(context) {
    return Text(
      widget.description!,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: pageViewDescriptionColor,
      ),
    );
  }
}
