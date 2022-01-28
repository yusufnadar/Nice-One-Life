import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(String email,String password)async{
    var _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    return _authResult;
  }

  Future<dynamic> loginUser(String email, String password) async {
    try{
      var _authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return _authResult;
    } on Exception catch(e){
      Get.snackbar<dynamic>('Error',e.toString());
    }
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

}