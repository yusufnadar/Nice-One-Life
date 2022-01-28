import 'package:new_one_life/utils/date.dart';

class MessageModel {
  late String? fromId;
  late String? toId;
  late String? message;
  late String? id;
  late DateTime? createdAt;

  MessageModel({
    this.fromId,
    this.toId,
    this.message,
    this.id,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        fromId: json['fromId'],
        toId: json['toId'],
        message: json['message'],
        id: json['id'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'fromId': fromId,
        'toId': toId,
        'id': id,
        'message': message,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}

class ChatModel {
  late String? otherId;
  late String? lastMessage;
  late String? myId;
  late String? name;
  late String? userPhoto;
  late String? fcmToken;
  late DateTime? createdAt;

  ChatModel({
    this.otherId,
    this.lastMessage,
    this.myId,
    this.userPhoto,
    this.name,
    this.fcmToken,
    this.createdAt,
  });

//'createdAt':DateTime.now(),'lastMessage':message,'myId':otherId,'otherId':myId
  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        otherId: json['otherId'],
        lastMessage: json['lastMessage'],
        myId: json['myId'],
        name: json['name'],
        userPhoto: json['userPhoto'],
        fcmToken: json['fcmToken'],
        createdAt: Utils.toDateTime(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'otherId': otherId,
        'lastMessage': lastMessage,
        'myId': myId,
        'createdAt': Utils.fromDateTimeToJson(createdAt!),
      };
}
