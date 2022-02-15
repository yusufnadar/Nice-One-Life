import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
<<<<<<< HEAD
  final FirebaseStorage _storage = FirebaseStorage.instance;
=======
  FirebaseStorage _storage = FirebaseStorage.instance;
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721

  Future uploadPhoto(File? photo, String fileID) async {
    var reference = _storage.ref('/posts').child(fileID);
    var uploadTask = reference.putFile(photo!);
    var url;
    await uploadTask.whenComplete(() async {
      url = await reference.getDownloadURL();
    });
    return url;
  }

  Future uploadCv(File? cv, String fileID) async{
    var reference = _storage.ref('/cvs').child(fileID);
    var uploadTask = reference.putFile(cv!);
    var url;
    await uploadTask.whenComplete(() async {
      url = await reference.getDownloadURL();
    });
    return url;
  }

}