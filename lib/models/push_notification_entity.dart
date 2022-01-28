import 'dart:math';

class PushNotificationEntity {
  PushNotificationEntity({
    this.body,
    this.title,
    this.topicName,
    this.token,
    this.userId,
    this.type,
    this.postId,
  });

  String? topicName;
  String? body;
  String? title;
  String? userId;
  var postId;
  String? type;
  var token;


  var rng = new Random();
  Map<String, dynamic> toJson() => {
    'to': token,
    'priority': 'high',
    'data': {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'content': {
        'payload':{
          'type': type,
          'userId': userId,
          'postId': postId,
        },
        "id": rng.nextInt(100000),
        "channelKey": "basic_channel",
        'body': body,
        'title': title,
      },
      "actionButtons": [
        {
          "key": "REPLY",
          "label": "Reply",
          "autoCancel": true,
          "buttonType":  "InputField"
        },
        {
          "key": "ARCHIVE",
          "label": "Archive",
          "autoCancel": true
        }
      ],
    },
    "mutable_content" : true,
    'content_available': true,
  };
}