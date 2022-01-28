import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/ui/drawer_pages/profile/edit_profile.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/profile_list_item.dart';

class Profile extends StatelessWidget {
  var isUpdate;

  Profile({Key? key, this.isUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'Profil Sayfası',
        ),
      ),
      body: GetBuilder<UserController>(
        initState: (cont) {
          if (isUpdate != null) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              Get.snackbar('Başarılı', 'Profiliniz Güncellenmiştir',
                  backgroundColor: Colors.green, colorText: Colors.white);
            });
          }
        },
        builder: (_) => Column(
          children: [
            sizedBox2,
            Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Color(0xffB5B5B5),
                  ),
                ),
                Positioned(
                    bottom: Get.height * 0.015,
                    right: Get.width * 0.32,
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => EditProfile())!.then((value) {
                            if(value){
                              Get.snackbar('Başarılı', 'Profiliniz Güncellenmiştir',
                                  backgroundColor: Colors.green, colorText: Colors.white);
                            }
                          });
                        },
                        child: Image.asset('assets/icons/edit.png'))),
              ],
            ),
            sizedBox3,
            Text(
              Get.find<UserController>().user.name,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            sizedBox6,
            ProfileListItem(),
          ],
        ),
      ),
    );
  }
}
