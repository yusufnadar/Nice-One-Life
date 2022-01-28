import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/conversation_container.dart';

class Conversations extends StatelessWidget {

  ScrollController? _scrollController;

  void _listeScrollListener() async {
    if (_scrollController!.offset >=
        _scrollController!.position.maxScrollExtent &&
        !_scrollController!.position.outOfRange) {
      Get.find<UserController>()
          .getMoreChatList();
    }
  }


  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(
          title: 'Sohbetler',
        ),
      ),
      body: StreamBuilder<List<ChatModel>>(
          stream: userController.getChatList(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text('Henüz Konuşma Yok'),
                );
              } else {
                userController.chats!.clear();
                userController.chats!.addAll(snapshot.data!);
                return GetX<UserController>(
                  init: UserController(),
                  initState: (func) {
                    _scrollController = ScrollController();
                    _scrollController!.addListener(_listeScrollListener);
                  },
                  dispose: (_){
                    _scrollController!.dispose();
                  },
                  builder: (_) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: false,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.06),
                      itemCount: _.chats!.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(future: Get.find<UserController>().getUserInformation(_.chats![index]),
                            builder: (context,snapshot1){
                              if(!snapshot1.hasData){
                                return Container();
                              }else{
                                _.chats![index].name = snapshot1.data!['name'];
                                _.chats![index].userPhoto = snapshot1.data!['userPhoto'];
                                _.chats![index].fcmToken = snapshot1.data!['fcmToken'];
                                return oneConversation(_.chats![index]);
                              }
                            });
                        //return control(_.chats.value[index]);
                      },
                    );
                  },
                );
              }
            }
          }),
    );
  }

  Stack oneConversation(ChatModel chat) {
    return Stack(
      children: [
        ConversationContainer(chat),
        Positioned(
          top: 10,
          right: 10,
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat.Hm().format(chat.createdAt!),
                style: TextStyle(
                    fontSize: 11,
                    color: messagePeopleNameColor,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ],
    );
  }
}
