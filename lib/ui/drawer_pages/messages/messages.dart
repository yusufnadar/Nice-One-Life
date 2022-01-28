import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/models/push_notification_entity.dart';
import 'package:new_one_life/services/notification_service/notification_handler1.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/message_container.dart';

class Messages extends GetWidget<UserController> {
  final userId;

  Messages({Key? key,this.userId}) : super(key: key);

  final textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void _listeScrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Get.find<UserController>()
          .getMoreMessages(userId, Get.find<UserController>().user.id);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: GetX<UserController>(
          init: UserController(),
          initState: (func) {
            getUserWithId();
            _scrollController.addListener(_listeScrollListener);
          },
          dispose: (_){
            _scrollController.dispose();
            controller.otherUser.name = null;
          },
          builder: (_) => MyAppBar(
                title: controller.otherUser.name != null ? controller.otherUser.name : ''
            ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
                stream:
                controller.getMessages(userId, controller.user.id),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('Henüz Mesaj Yok'),
                      );
                    } else {
                      controller.messages!.clear();
                      controller.messages!.addAll(snapshot.data!);
                      return Obx(
                          () => ListView.builder(
                          controller: _scrollController,
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06),
                          itemCount: controller.messages!.length,
                          itemBuilder: (context, index) {
                            return MessageContainer(
                                isMe: controller.messages![index].fromId == controller.user.id
                                    ? false
                                    : true,
                                messageModel: controller.messages![index]);
                          },
                        ),
                      );
                    }
                  }
                }),
          ),
          sendMessageButton(),
        ],
      ),
    );
  }

  sendMessageButton() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.02),
        decoration: BoxDecoration(
            color: sendMessageContainerColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none,hintText: 'Mesaj yazınız'),
              controller: textController,
            )),
            GestureDetector(
                onTap: () async {
                  if(_scrollController.hasClients){
                    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  }
                    controller.addMessage(textController.text, userId,
                        Get.find<UserController>().user.id);
                  final pushNotification = PushNotificationEntity();
                  pushNotification.title = controller.user.name;
                  pushNotification.body = textController.text;
                  pushNotification.token = controller.otherUser.fcmToken;
                  pushNotification.userId = controller.user.id;
                  final notification = NotificationHandler1();
                  await notification.sendNotification(pushNotificationEntity: pushNotification);
                  textController.clear();
                },
                child: Image.asset('assets/icons/Send.png'))
          ],
        ),
      ),
    );
  }

  Future<void> getUserWithId() async{
    await controller.getUserWithId(userId);
  }

}
