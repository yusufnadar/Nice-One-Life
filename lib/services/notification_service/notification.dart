import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/ui/drawer_pages/address/address.dart';
import 'package:new_one_life/ui/drawer_pages/messages/messages.dart';
import 'package:new_one_life/ui/drawer_pages/profile/product_basket.dart';
import 'package:new_one_life/ui/drawer_pages/doctors.dart';
import 'package:new_one_life/ui/drawer_pages/proteins.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseNotifications {
  FirebaseMessaging? _messaging;

  void setupFirebase() {
    _messaging = FirebaseMessaging.instance;
    firebaseCloudMessageListener();
  }

  void firebaseCloudMessageListener() async {
    await _messaging!.requestPermission(
      alert: true,
      badge: true,
      announcement: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _messaging!.getToken().then((token) async {
      var ins = await SharedPreferences.getInstance();
      ins.setString('token', token!);
    });

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if(value != null){
        Get.to(()=>Proteins());
      }else{
       // bildirim gelmediyse
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var isDevice = message.data['content'];
      if(isDevice != null){
        var content = json.decode(message.data['content']);
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: content['id'],
              channelKey: 'basic_channel',
              title: content['title'],
              body: content['body'],
              payload: {'data':json.encode(content['payload'])},
            )
        );
      }else{
        var msg = {
          'payload':{
            'type': 'Link',
            'link':message.data['link']
          },
        };
        AwesomeNotifications().createNotification(
            content: NotificationContent(

              id: 1,
              channelKey: 'basic_channel',
              title: message.notification!.title,
              body: message.notification!.body,
              payload: {'data':json.encode(msg['payload'])},
            )
        );
      }

      /*
       if(message.data['type'] == 'link'){
        var msg = {
          'payload':{
            'type': 'Link',
            'link':message.data['link']
          },
        };
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: int.parse(message.data['id']),
              channelKey: 'basic_channel',
              title: message.notification!.title,
              body: message.notification!.body,
              payload: {'data':json.encode(msg['payload'])},
            )
        );
      }else{
        var content = json.decode(message.data['content']);
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: content['id'],
              channelKey: 'basic_channel',
              title: content['title'],
              body: content['body'],
              payload: {'data':json.encode(content['payload'])},
            )
        );
      }
       */
    });



    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.to(()=>Doctors());
      if(message.data['type'] == 'link'){
        var msg = {
          'payload':{
            'type': 'Link',
            'link':message.data['link']
          },
        };
        launch(message.data['link']);
      }
    });
  }

  afterClickNotification(){
    AwesomeNotifications().actionStream.listen(
            (receivedNotification) async {
          var message;
          if(receivedNotification.payload!['data'] != null){
            message = json.decode(receivedNotification.payload!['data']!);
          }
          Get.to(()=>Messages(userId: message['userId'],));
        }
    );
  }
}


