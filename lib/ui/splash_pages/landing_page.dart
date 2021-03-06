import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/auth_controller.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/ui/splash_pages/page_views.dart';
import 'package:new_one_life/widget/loading_screen_scaffold.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(Get.find<AuthController>().isLoading == true){
<<<<<<< HEAD
        return const LoadingScreenScaffold();
=======
        return LoadingScreenScaffold();
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
      }else{
        if (Get.find<UserController>().user.id != null) {
          return HomePage();
        } else {
          return PageViews();
        }
      }
    });
  }
}
