// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/close_keyboard.dart';
import 'package:new_one_life/widget/dotted_container.dart';
import 'package:new_one_life/widget/post_text.dart';

class AddPostController extends GetxController {
  Rxn<File>? _photo = Rxn<File>();
  File? get photo => _photo!.value;
  File? setPost(File? photo) => _photo!.value = photo;

  Rx<bool?> _isLoading = false.obs;
  bool? get isLoading => _isLoading.value;
  bool? setLoading(bool? isLoading) => _isLoading.value = isLoading;
}

class AddPost extends StatelessWidget {
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CloseKeyboard(
      child: GetX<AddPostController>(
        builder: (_) {
          if (_.isLoading == true) {
            return Scaffold(
              body: Center(child: Lottie.asset('assets/lottie/loading.json')),
            );
          } else {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(Get.height * 0.13),
                child: MyAppBar(
                  title: 'Yorum Yaz',
                  isHomePage: false,
                ),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PostText(
                        controller: descriptionController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Bu alan boş bırakılamaz';
                          } else
                            return null;
                        },
                      ),
                      sizedBox5,
                      _.photo == null
                          ? GestureDetector(
                              onTap: () async {
                                var image = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                var cropPhoto = await ImageCropper.cropImage(
                                  sourcePath: image!.path,
                                  maxHeight: 1080,
                                  maxWidth: 1080,
                                  aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                                );
                                _.setPost(File(cropPhoto!.path));
                              },
                              child: DottedContainer(
                                imageOrIcon:
                                    Image.asset('assets/icons/camera.png'),
                                text: 'Fotoğraf Ekleyiniz',
                              ),
                            )
                          : DottedContainer(
                              imageOrIcon: Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              ),
                              text: 'Fotoğraf Başarıyla Yüklendi',
                            ),
                      if (_.photo != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _.setPost(null);
                            },
                            child: Text(
                              'Fotoğrafı Kaldırmak İçin Tıklayınız',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 11),
                            ),
                          ),
                        )
                      else
                        Container(),
                      Container(
                        margin:
                            EdgeInsets.only(top: Get.height * 0.32, bottom: 20),
                        child: AuthButton(
                          text: 'Yorum Gönder',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _.setLoading(true);
                              _formKey.currentState!.save();
                              await Get.find<UserController>()
                                  .addPost(descriptionController.text, _.photo,
                                      Get.find<UserController>().user)
                                  .then((value) {
                                if (value) {
                                  Get.to(() => HomePage());
                                }
                              });
                              _.setLoading(false);
                              _.setPost(null);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
