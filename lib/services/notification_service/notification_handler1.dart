import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_one_life/models/push_notification_entity.dart';

class NotificationHandler1 {

  Future<bool> sendNotification({PushNotificationEntity? pushNotificationEntity}) async {
    var serverToken =
        'AAAA4b03FxE:APA91bE_jv0DONHShwdNwo_tZRTDMhgYtCM1lRdHfwUSVjPK18-qG45YOecC-7Inxooyw_7bwBqIvfq_LpuEjlaeCgaMawTI42s32vDt3cDv3WW9rrYNNZGgzLdFvPREBAhJ4TmgSydQ';
    var _json = pushNotificationEntity!.toJson();
    var encoded = json.encode(_json);
    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: encoded,
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

