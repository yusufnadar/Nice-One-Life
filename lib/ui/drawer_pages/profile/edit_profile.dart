import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_text.dart';

class EditProfileController extends GetxController {
  TextEditingController? nameController;
  TextEditingController? phoneController;

  @override
  void onInit() {
    super.onInit();
    var userController = Get.put(UserController());
    nameController = TextEditingController(text: userController.user.name);
    phoneController = TextEditingController(text: userController.user.phone);
  }

  @override
  void onClose() {
    super.onClose();
    nameController!.dispose();
    phoneController!.dispose();
  }
}


class EditProfile extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  File? file;
  @override
  Widget build(BuildContext context) {
    final editController = Get.put<EditProfileController>(EditProfileController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'Profili Düzenleme',
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBox8,
              Text(
                'Ad Soyad',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              sizedBox1,
              AuthText(
                controller: editController.nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                },
              ),
              sizedBox3,
              Text(
                'Telefon Numarası',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              sizedBox1,
              AuthText(
                controller: editController.phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Bu alan boş bırakılamaz';
                  }
                },
              ),
              sizedBox3,
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    file = File(result.files.single.path!);
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  height: Get.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 26,
                      ),
                      sizedBoxW3,
                      Text(
                        file != null ? 'Cv Ekle' : 'Cv Güncelle',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              sizedBox3,
              GestureDetector(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    Get.find<UserController>().updateProfile(editController.nameController!.text,editController.phoneController!.text,file ?? null);
                  }else{
                    Get.snackbar('Uyarı', 'Boş alanları doldurunuz');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  height: Get.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        color: Colors.white,
                        size: 26,
                      ),
                      sizedBoxW3,
                      Text(
                        'Kaydet',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    ],
                  ),
                ),
              ),
              sizedBox2,
            ],
          ),
        ),
      ),
    );
  }
}
