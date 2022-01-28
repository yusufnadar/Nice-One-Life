import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/auth_controller.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/models/address.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/models/user.dart';
import 'package:new_one_life/services/storage_service.dart';
import 'package:new_one_life/services/user_service.dart';
import 'package:new_one_life/ui/drawer_pages/profile/profile.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:uuid/uuid.dart';

class UserController extends GetxController {
  final Rx<UserModel?> _userModel = UserModel().obs;
  UserModel get user => _userModel.value!;
  set user(UserModel? value) => _userModel.value = value;

  final RxList<PackageModel> _packageBasket = <PackageModel>[].obs;
  List<PackageModel> get packageBasket => _packageBasket.value;
  set setPackageBasket(List<PackageModel> packages) => _packageBasket.value = packages;

  final RxList<AddressModel> _billAddress = <AddressModel>[].obs;
  List<AddressModel> get billAddress => _billAddress.value;
   get billAddress2 => _billAddress;
  set setBillAddress(List<AddressModel> billAddress) => _billAddress.value = billAddress;

  final RxList<AddressModel> _deliveryAddress = <AddressModel>[].obs;
  List<AddressModel> get deliveryAddress => _deliveryAddress.value;
  set setDeliveryAddress(List<AddressModel> deliveryAddress) => _deliveryAddress.value = deliveryAddress;

  final RxList<ProductModel> _productBasket = <ProductModel>[].obs;
  List<ProductModel> get productBasket => _productBasket.value;
  get productBasket2 => _productBasket;
  set setProductBasket(List<ProductModel> product) => _productBasket.value = product;

  RxBool isLoading = false.obs;


  final UserService? _userService = UserService();
  final StorageService? _storageService = StorageService();

  final _messages = <MessageModel>[].obs;
  final _chats = <ChatModel>[].obs;

  final Rx<UserModel?> _otherUser = UserModel().obs;
  UserModel get otherUser => _otherUser.value!;
  set otherUser(UserModel? value) => _otherUser.value = value;


  List<MessageModel>? get messages => _messages.value;
  List<ChatModel>? get chats => _chats.value;


  void saveUser(UserModel userModel) async {
    try {
      if (await _userService!.saveUser(userModel)) {
        user = userModel;
        Get.offAll(() => HomePage())?.then((value) => Get.find<AuthController>().isLoading = false);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void clear() {
    _userModel.value = UserModel();
  }

  Future currentUser(id) async {
    user = await _userService!.currentUser(id);
    Get.offAll(() => HomePage())?.then((value) => Get.find<AuthController>().isLoading = false);
    }

  Future addPost(String description, File? photo, user) async {
    String fileID = Uuid().v4();
    if (photo != null) {
      var photoUrl = await _storageService!.uploadPhoto(photo, fileID);
      return await _userService!.addPost(description, photoUrl, user, fileID);
    } else {
      return await _userService!.addPost(description, null, user, fileID);
    }
  }

  Stream<List<MessageModel>> getMessages(otherId, myId) {
    return _userService!.getMessages(otherId, myId);
  }

  Stream<List<ChatModel>> getChatList() {
    return _userService!.getChatList();
  }

  void addMessage(String message, otherId, myId) {
    _userService!.addMessage(message, otherId, myId);
  }

  getMoreMessages(otherId, myId) async {
    var mesajlar = await _userService!.getMoreMessages(otherId, myId);
    messages!.addAll(mesajlar);
  }

  Future<DocumentSnapshot<Map<String,dynamic>>> getUserInformation(ChatModel value) async {
    return await _userService!.getUserInformation(value);
  }

  Future<UserModel?> getUserWithId(userId) async{
    otherUser = await _userService!.getUserWithId(userId);
  }

  Future updateProfile(String name, String phone, File? cv) async{
    try{
      String fileID = const Uuid().v4();
      if (cv != null) {
        var cvUrl = await _storageService!.uploadCv(cv, fileID);
        await _userService!.updateProfile(name, phone, cvUrl, fileID);
        user = await _userService!.currentUser(userId);
        isLoading.value = false;
        Get.back(result: true);
      } else {
        await _userService!.updateProfile(name, phone, null, fileID);
        user = await _userService!.currentUser(userId);
        isLoading.value = false;
        Get.back(result: true);
      }
    }catch(e){
      Get.snackbar('Hata', e.toString());
    }
  }

  Stream<List<ChatModel>> getMoreChatList() {
    return  _userService!.getMoreChatList();
  }

  Future<String?> addToBasket(type, id, price) async{
    try{
      var result = await _userService!.addToBasket(type,id,price);
      return result;
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future getPackageBasket() async{
    try{
      setPackageBasket = await _userService!.getPackageBasket();
    }catch(e){
      Get.snackbar('Hata', e.toString());
    }
  }

  Future getProductBasket() async{
    try{
      setProductBasket = await _userService!.getProductBasket();
    }catch(e){
      Get.snackbar('Hata', e.toString());
    }
  }

  Future<bool?> deletePackageFromBasket(id,price) async{
    try{
      var result = await _userService!.deletePackageFromBasket(id,price);
      _packageBasket.removeWhere((element) => element.id == id);
      return result;
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future<bool?> deleteProductFromBasket(id, price) async{
    try{
      var result = await _userService!.deleteProductFromBasket(id,price);
      _productBasket.removeWhere((element) => element.id == id);
      return result;
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future decrease(id, price) async{
    try{
      var result = await _userService!.decrease(id,price);
      return result;
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future<bool?> addAddress(List<String> adreslist, type) async{
    try{
      return await _userService!.addAddress(adreslist,type);
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  void getAddresses(type) async{
    try{
      if(type == 'Teslimat'){
        setDeliveryAddress = await _userService!.getAddresses(type);
      }else{
        setBillAddress =  await _userService!.getAddresses(type);
      }
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  void deleteAddress(id, type) async{
    try{
      var result = await _userService!.deleteAddress(id,type);
      if(result){
        deliveryAddress.removeWhere((element) => element.id == id);
        _deliveryAddress.refresh();
      }
    }catch(e){
      Get.snackbar('Hata', e.toString());
    }
  }

  Future editAddress(List<String> adreslist, type, id) async{
    try{
      _userService!.editAddress(adreslist,type,id);
          return true;
    }catch(e){
      Get.snackbar('Hata', e.toString());
    }
  }

  Stream<double>? getUserBasketPrice(type) {
    try{
      return _userService!.getUserBasketPrice(type);
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future finishPay(liste) async{
    try{
      return _userService!.finishPay(liste);
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  Future finishPay2(liste) async{
    try{
      return _userService!.finishPay2(liste);
    }catch(e){
      Get.snackbar('Hata', e.toString());
      return null;
    }
  }

  void getOrders() {}

}
