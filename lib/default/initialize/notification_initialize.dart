import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Initialize{

  static Future initializing() async {
    WidgetsFlutterBinding
        .ensureInitialized(); // await kullandığımız yerde bunu kullanıyoruz
    await Firebase.initializeApp();
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // uygulama sağa ya da sola dönmeyecek
    // bildirimleri aktifleştiriyoruz
    NotificationInitialize.notificationInitialize();
  }
}

class NotificationInitialize{

  static Future<void> notificationInitialize() async{
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
        )
      ],
      debug: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if(message.data['content'] != null){
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
  // content dışındakiler push notificationdan geliyor o da otomatik oluşuyor

}