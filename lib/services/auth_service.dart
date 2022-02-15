import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService {

<<<<<<< HEAD
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(String email,String password)async{
    var _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    return _authResult;
  }

  Future<dynamic> loginUser(String email, String password) async {
    try{
      var _authResult = await _firebaseAuth.signInWithEmailAndPassword(
=======
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(String email,String password)async{
    UserCredential _authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
    return _authResult;
  }

  Future loginUser(String email, String password) async {
    try{
      UserCredential _authResult = await _firebaseAuth.signInWithEmailAndPassword(
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
        email: email.trim(),
        password: password.trim(),
      );
      return _authResult;
<<<<<<< HEAD
    } on Exception catch(e){
      Get.snackbar<dynamic>('Error',e.toString());
=======
    }catch(e){
      //return null;
      Get.snackbar('Error',e.toString());
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
    }
  }

  Future<void> signOutUser() async {
    await _firebaseAuth.signOut();
  }

}