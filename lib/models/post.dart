import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  var id;
  var description;
  var photo;
  var userId;
  var userPhoto;
  var name;
  var createdAt;

  PostModel({this.id, this.description, this.photo,this.userId,this.userPhoto,this.name,this.createdAt});

  factory PostModel.fromJson(var json) => PostModel(
    // Map<String, dynamic>
    description: json["description"],
    photo: json["photo"],
    userPhoto: json["userPhoto"],
    name: json["name"],
    id: json["id"],
    userId: json["userId"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "photo": photo,
    "userId": userId,
    "id": id,
    "createdAt": createdAt,
  };

  factory PostModel.fromDoc(DocumentSnapshot? source){
    return PostModel.fromJson(source!.data());
  }
}
