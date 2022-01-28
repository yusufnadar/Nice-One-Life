import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/message.dart';

class MessageContainer extends StatelessWidget {

  final isMe;
  MessageModel? messageModel;

  MessageContainer({Key? key, this.isMe, this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height*0.04),
      child: Column(
        crossAxisAlignment: isMe == true ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: Get.width*0.65),
            padding: EdgeInsets.symmetric(vertical: Get.height*0.025,horizontal: Get.width*0.04),
            decoration: BoxDecoration(
              color: isMe == true ? sendMessageContainerColor : mainColor,
              borderRadius: isMe == true ? BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topLeft: Radius.circular(30),
              ) : BorderRadius.only(
                bottomLeft: Radius.circular(40),
                topRight: Radius.circular(30),
                topLeft: Radius.circular(40),
              ),
            ),
            child: Text(messageModel!.message!,style: TextStyle(fontSize: 13,color: isMe == true ? messagePeopleNameColor : whiteColor,fontWeight: FontWeight.bold),),
          ),
          sizedBox1,
          Text(DateFormat.Hm('tr').format(messageModel!.createdAt!),style: TextStyle(fontWeight: FontWeight.bold,color: messagePeopleNameColor,fontSize: 12),),
        ],
      ),
    );
  }
}
