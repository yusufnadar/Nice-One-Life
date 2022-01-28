import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/ui/drawer_pages/messages/messages.dart';

class ConversationContainer extends StatelessWidget {
  ChatModel chat;

  ConversationContainer(this.chat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => Messages(
              userId: chat.otherId,
            ),);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.03, horizontal: Get.height * 0.015),
        margin: EdgeInsets.only(bottom: Get.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textFormBackgroundColor),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                chat.userPhoto!
              ),
              backgroundColor: Colors.transparent,
              radius: 24,
            ),
            sizedBoxW3,
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name!,
                    style: TextStyle(
                        color: messagePeopleNameColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Text(
                    chat.lastMessage!,
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
