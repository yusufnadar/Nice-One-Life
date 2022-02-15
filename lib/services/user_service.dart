import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/models/address.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/models/post.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/models/user.dart';
import 'package:uuid/uuid.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int perPageChats = 10;
  var _lastChat;

  Future<bool> saveUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel?> currentUser(id) async {
    try {
      var userDocSnapshot = await _firestore.collection('users').doc(id).get();
      return UserModel.fromDoc(userDocSnapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future addPost(String description, photoUrl, UserModel user, fileID) async {
    try {
      if (photoUrl != null) {
        PostModel postModel = PostModel(
          id: fileID,
          description: description,
          photo: photoUrl,
          userId: user.id,
          createdAt: DateTime.now(),
        );
        await _firestore
            .collection('posts')
            .doc(fileID)
            .set(postModel.toJson());
      } else {
        PostModel postModel = PostModel(
          description: description,
          userId: user.id,
          id: fileID,
          createdAt: DateTime.now(),
        );
        await _firestore
            .collection('posts')
            .doc(fileID)
            .set(postModel.toJson());
      }
      PostModel postModel2 = PostModel(
          id: fileID,
          description: description,
          userId: user.id,
          userPhoto: user.userPhoto,
          name: user.name,
          createdAt: DateTime.now(),
          photo: photoUrl ?? null);
      Get.find<DataController>().posts!.insert(0, postModel2);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  DocumentSnapshot? _lastMessage;

  Stream<List<MessageModel>> getMessages(String otherId, myId) {
    var snapshot = FirebaseFirestore.instance
        .collection('chats/$otherId-$myId/messages')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots();
    return snapshot.map((messageList) {
      if (messageList.docs.isNotEmpty) {
        _lastMessage = messageList.docs[messageList.docs.length - 1];
      }
      return messageList.docs
          .map((message) => MessageModel.fromJson(message.data()))
          .toList();
    });
  }

  Future<List<MessageModel>> getMoreMessages(String otherId, myId) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('chats/$myId-$otherId/messages')
        .orderBy('createdAt', descending: true)
        .limit(20)
        .startAfterDocument(_lastMessage!)
        .get();
    if (snapshot.docs.isNotEmpty) {
      _lastMessage = snapshot.docs[snapshot.docs.length - 1];
    }
    return snapshot.docs
        .map((message) => MessageModel.fromJson(message.data()))
        .toList();
  }

  Future<void> addMessage(String message, otherId, myId) async {
    String messageId = Uuid().v4();
    final refMessages = FirebaseFirestore.instance
        .doc('chats/$myId-$otherId/messages/$messageId');
    final refMessages2 = FirebaseFirestore.instance
        .doc('chats/$otherId-$myId/messages/$messageId');
    final newMessage = MessageModel(
      id: messageId,
      fromId: myId,
      toId: otherId,
      message: message,
      createdAt: DateTime.now(),
    );
    await FirebaseFirestore.instance.doc('chats/$myId-$otherId').set({
      'createdAt': DateTime.now(),
      'lastMessage': message,
      'myId': myId,
      'otherId': otherId
    });
    await FirebaseFirestore.instance.doc('chats/$otherId-$myId').set({
      'createdAt': DateTime.now(),
      'lastMessage': message,
      'myId': otherId,
      'otherId': myId
    });
    await refMessages.set(newMessage.toJson());
    await refMessages2.set(newMessage.toJson());
  }

  Stream<List<ChatModel>> getChatList() {
    var snapshot = FirebaseFirestore.instance
        .collection("chats")
        .where("myId", isEqualTo: Get.find<UserController>().user.id)
        .orderBy("createdAt", descending: true)
        .limit(perPageChats)
        .snapshots();
    return snapshot.map((chatList) {
      if (chatList.docs.isNotEmpty) {
        _lastChat = chatList.docs[chatList.docs.length - 1];
      }
      return chatList.docs
          .map((message) => ChatModel.fromJson(message.data()))
          .toList();
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformation(
      ChatModel value) async {
    return await _firestore.collection('users').doc(value.otherId).get();
  }

  Future<UserModel?> getUserWithId(userId) async {
    try {
      var userDocSnapshot =
          await _firestore.collection('users').doc(userId).get();
      return UserModel.fromDoc(userDocSnapshot);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateProfile(
      String name, String phone, cvUrl, String fileID) async {
    try {
      if (cvUrl != null) {
        await _firestore
            .collection('users')
            .doc(Get.find<UserController>().user.id)
            .update({'name': name, 'phone': phone, 'cv': cvUrl});
      } else {
        await _firestore
            .collection('users')
            .doc(Get.find<UserController>().user.id)
            .update({'name': name, 'phone': phone});
      }
    } catch (e) {
      Get.snackbar('Hata', e.toString());
    }
  }

  Stream<List<ChatModel>> getMoreChatList() {
    var snapshot = FirebaseFirestore.instance
        .collection("chats")
        .where("myId", isEqualTo: Get.find<UserController>().user.id)
        .orderBy("createdAt", descending: true)
        .limit(perPageChats)
        .startAfter(_lastChat)
        .snapshots();
    return snapshot.map((chatList) {
      if (chatList.docs.isNotEmpty) {
        _lastChat = chatList.docs[chatList.docs.length - 1];
      }
      return chatList.docs
          .map((message) => ChatModel.fromJson(message.data()))
          .toList();
    });
  }

  Future<String?> addToBasket(type, id, price) async {
    if (type == 'package') {
      var here = await FirebaseFirestore.instance
          .collection('packageBasket')
<<<<<<< HEAD
          .doc(userId)
          .collection('packageBasket')
=======
      .doc(Get.find<UserController>().user.id)
      .collection('packageBasket')
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
          .doc(id)
          .get();
      if (here.data() == null) {
        await FirebaseFirestore.instance
            .collection('packageBasket')
            .doc(Get.find<UserController>().user.id)
            .collection('packageBasket')
            .doc(id)
            .set({'packageId': id});
        await FirebaseFirestore.instance
            .collection('users')
            .doc(Get.find<UserController>().user.id)
            .update({'packageBasket': FieldValue.increment(price)});
      }
      return 'package';
    } else if (type == 'product') {
      var here = await FirebaseFirestore.instance
          .collection('productBasket')
          .doc(Get.find<UserController>().user.id)
          .collection('productBasket')
          .doc(id)
          .get();
      if (here.data() == null) {
        await FirebaseFirestore.instance
            .collection('productBasket')
            .doc(Get.find<UserController>().user.id)
            .collection('productBasket')
            .doc(id)
            .set({'productId': id, 'piece': 1});
      } else {
        await FirebaseFirestore.instance
            .collection('productBasket')
            .doc(Get.find<UserController>().user.id)
            .collection('productBasket')
            .doc(id)
            .update({'piece': FieldValue.increment(1)});
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<UserController>().user.id)
          .update({'productBasket': FieldValue.increment(price)});
      return 'product';
    }
  }

  Future<List<PackageModel>> getPackageBasket() async {
    var list = <PackageModel>[];
<<<<<<< HEAD
    var snapshot = await FirebaseFirestore.instance
        .collection('packageBasket')
        .doc(Get.find<UserController>().user.id)
        .collection('packageBasket')
        .get();
=======
    var snapshot =
        await FirebaseFirestore.instance.collection('packageBasket').doc(Get.find<UserController>().user.id)
            .collection('packageBasket').get();
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
    for (var item in snapshot.docs) {
      var snapshot1 = await FirebaseFirestore.instance
          .collection('packages')
          .doc(item.data()['packageId'])
          .get();
      list.add(PackageModel.fromJson(snapshot1.data()!));
    }
    return list;
  }

  Future<List<ProductModel>> getProductBasket() async {
    var list = <ProductModel>[];
<<<<<<< HEAD
    var snapshot = await FirebaseFirestore.instance
        .collection('productBasket')
        .doc(Get.find<UserController>().user.id)
        .collection('productBasket')
        .get();
=======
    var snapshot =
        await FirebaseFirestore.instance.collection('productBasket').doc(Get.find<UserController>().user.id)
            .collection('productBasket').get();
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
    for (var item in snapshot.docs) {
      var snapshot1 = await FirebaseFirestore.instance
          .collection('products')
          .doc(item.data()['productId'])
          .get();
      var secondMap = new Map<String, dynamic>.from(snapshot1.data()!);
      secondMap.putIfAbsent('piece', () => item.data()['piece']);
      list.add(ProductModel.fromJson(secondMap));
    }
    return list;
  }

  Future<bool> deletePackageFromBasket(id, price) async {
    await FirebaseFirestore.instance
        .collection('packageBasket')
        .doc(Get.find<UserController>().user.id)
        .collection('packageBasket')
        .doc(id)
        .delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserController>().user.id)
        .update({'packageBasket': FieldValue.increment(-price)});
    return true;
  }

  Future<bool> deleteProductFromBasket(id, price) async {
    await FirebaseFirestore.instance
        .collection('productBasket')
        .doc(Get.find<UserController>().user.id)
        .collection('productBasket')
        .doc(id)
        .delete();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserController>().user.id)
        .update({'productBasket': FieldValue.increment(-price)});
    return true;
  }

  Future decrease(String id, price) async {
    await FirebaseFirestore.instance
        .collection('productBasket')
        .doc(Get.find<UserController>().user.id)
        .collection('productBasket')
        .doc(id)
        .update({'piece': FieldValue.increment(-1)});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserController>().user.id)
        .update({'productBasket': FieldValue.increment(-price)});
    return 'product';
  }

  Future<bool?> addAddress(List<String> adreslist, type) async {
    var uid = Uuid().v4();
    await FirebaseFirestore.instance
        .collection('addresses')
        .doc(Get.find<UserController>().user.id)
        .collection(type)
        .doc(uid)
        .set({
      'name': adreslist[0],
      'surname': adreslist[1],
      'city': adreslist[2],
      'address': adreslist[3],
      'addressName': adreslist[4],
      'phoneNumber': adreslist[5],
      'id': uid
    });
    return true;
  }

  Future<List<AddressModel>> getAddresses(type) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('addresses')
        .doc(Get.find<UserController>().user.id)
        .collection(type)
        .get();
    return snapshot.docs.map((e) => AddressModel.fromJson(e.data())).toList();
  }

  Future<bool> deleteAddress(id, type) async {
    await FirebaseFirestore.instance
        .collection('addresses')
        .doc(Get.find<UserController>().user.id)
        .collection(type)
        .doc(id)
        .delete();
    return true;
  }

  Future editAddress(List<String> adreslist, type, id) async {
    print(id);
    print(type);
    await FirebaseFirestore.instance
        .collection('addresses')
        .doc(Get.find<UserController>().user.id)
        .collection(type)
        .doc(id)
        .update({
      'name': adreslist[0],
      'surname': adreslist[1],
      'city': adreslist[2],
      'address': adreslist[3],
      'addressName': adreslist[4],
    });
  }

  Stream<double> getUserBasketPrice(type) {
    if (type == 'product') {
      var snapshot = FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<UserController>().user.id)
          .snapshots();
      return snapshot.map(
          (event) => double.parse((event.data()!['productBasket']).toString()));
    } else {
      var snapshot = FirebaseFirestore.instance
          .collection('users')
          .doc(Get.find<UserController>().user.id)
          .snapshots();
      return snapshot.map(
          (event) => double.parse((event.data()!['packageBasket']).toString()));
    }
  }

  Future finishPay(List<Map<String, dynamic>> liste) async {
<<<<<<< HEAD
    for (var element in liste) {
      await FirebaseFirestore.instance
          .collection('myPackages')
          .doc(userId)
          .collection('myPackages')
          .doc(element['id'])
          .set({'id': element['id'],'date':DateTime.now()});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'packageBasket': 0});
    }
    var snapshot = await FirebaseFirestore.instance
        .collection('packageBasket')
        .doc(userId)
        .collection('packageBasket')
        .get();
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
    return true;
  }

  Future finishPay2(List<Map<String, dynamic>> liste) async {
    for (var element in liste) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(userId)
          .collection('orders')
          .doc(element['id'])
          .set({'id': element['id'], 'piece': element['piece'],'date':DateTime.now()});
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({
      'productBasket': 0
    });
    var snapshot = await FirebaseFirestore.instance
        .collection('productBasket')
        .doc(userId)
        .collection('productBasket')
        .get();
    for (DocumentSnapshot ds in snapshot.docs) {
      ds.reference.delete();
    }
    return true;
=======
    var packageList = [];
    liste.forEach((element) {
      packageList.add(element['id']);
    });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Get.find<UserController>().user.id)
        .update({'packages': packageList,'packageBasket':0});
    var snapshot = await FirebaseFirestore.instance
        .collection('packageBasket')
        .doc(Get.find<UserController>().user.id).collection('packageBasket').get();
    for (DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
  }
}
