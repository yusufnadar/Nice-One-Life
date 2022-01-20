import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/models/user.dart';
import 'package:new_one_life/services/auth_service.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final _firebaseMessaging = FirebaseMessaging.instance;

  Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;
  User setUser(User user) => _firebaseUser.value = user;

  var _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  @override
  void onInit() {
    isLoading = true;
    if (_auth.currentUser != null) {
      currentUser(_auth.currentUser?.uid);
    } else {
      isLoading = false;
    }
    super.onInit();
  }

  void currentUser(id) async {
    await Get.find<UserController>().currentUser(id);
  }

  Future<void> register(name, phone, email, password, gender, isDoctor) async {
    try {
      isLoading = true;
      UserCredential _authResult = await _authService.register(email.trim(), password.trim());
      var fcmToken = await _firebaseMessaging.getToken();
      if (_authResult.user != null) {
        UserModel userModel = UserModel(
            id: _authResult.user?.uid,
            name: name,
            email: email,
            gender: gender,
            isDoctor: isDoctor,
            phone: phone,
            fcmToken: fcmToken,
            cv: '',
            packageBasket:0,
            productBasket:0,
            userPhoto: 'https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png');
        Get.find<UserController>().saveUser(userModel);
      } else {
        isLoading = false;
        Get.snackbar('Error', 'Kullanıcı Bulunamadı');
      }
    } catch (e) {
      isLoading = false;
      Get.snackbar('Error', e.toString());
    }
  }

  Future login(String email, String password) async {
    try {
      isLoading = true;
      UserCredential? _authResult = await _authService.loginUser(email.trim(), password.trim());
      if (_authResult!.user != null) {
        Get.find<UserController>().currentUser(_authResult.user!.uid);
      } else {
        isLoading = false;
        Get.snackbar('Error', 'Kullanıcı Bulunamadı');
      }
    } catch (e) {
    } finally {
      isLoading = false;
    }
  }
}

//_firebaseUser.bindStream(_auth.authStateChanges());
