import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  var id;
  var name;
  var phone;
  var email;
  var gender;
  var isDoctor;
  var userPhoto;
  var fcmToken;
  var cv;
  var packageBasket;
  var productBasket;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.gender,
    this.isDoctor,
    this.userPhoto,
    this.fcmToken,
    this.cv,
    this.packageBasket,
    this.productBasket,
  });

  factory UserModel.fromJson(var json) => UserModel(
        // Map<String, dynamic>
        email: json["email"],
        name: json["name"],
        id: json["id"],
        phone: json["phone"],
        gender: json["gender"],
        isDoctor: json["isDoctor"],
        fcmToken: json["fcmToken"],
        userPhoto: json["userPhoto"],
    packageBasket: json["packageBasket"],
    productBasket: json["productBasket"],
        cv: json["cv"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "phone": phone,
        "id": id,
        "gender": gender,
        "isDoctor": isDoctor,
        "fcmToken": fcmToken,
        "userPhoto": userPhoto,
        "packageBasket": packageBasket,
        "productBasket": productBasket,
      };

  factory UserModel.fromDoc(DocumentSnapshot? source) {
    return UserModel.fromJson(source!.data());
  }
}
