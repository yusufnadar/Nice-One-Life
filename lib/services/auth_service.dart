import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(String email,String password)async{
    UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    return _authResult;
  }

  Future loginUser(String email, String password) async {
    try{
      UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return _authResult;
    }catch(e){
      //return null;
      Get.snackbar('Error',e.toString());
    }
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

}