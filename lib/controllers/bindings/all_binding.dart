import 'package:get/get.dart';
import 'package:new_one_life/controllers/auth_controller.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/ui/drawer_pages/address/address.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/distance_selling.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/privacy.dart';
import 'package:new_one_life/ui/drawer_pages/body_mass.dart';
import 'package:new_one_life/ui/drawer_pages/doctors.dart';
import 'package:new_one_life/ui/drawer_pages/payment/fill_address.dart';
import 'package:new_one_life/ui/drawer_pages/payment/pay.dart';
import 'package:new_one_life/ui/drawer_pages/profile/edit_profile.dart';
import 'package:new_one_life/ui/drawer_pages/profile/package_basket.dart';
import 'package:new_one_life/ui/drawer_pages/proteins.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/ui/post/add_post.dart';
import 'package:new_one_life/ui/splash_pages/page_views.dart';

import '../data_controller.dart';

class AllBindings extends Bindings{
  @override
  void dependencies() {
    //Get.put<AuthController>(() => AuthController());
    Get.put<UserController>(UserController(),permanent: true);
    Get.put<AuthController>(AuthController(),permanent: true);
    Get.put<HomePageController>(HomePageController(),permanent: true);
    Get.put<AddPostController>(AddPostController(),permanent: true);
    Get.put<DataController>(DataController(),permanent: true);
    Get.put<DoctorsController>(DoctorsController(),permanent: true);
    Get.put<ProteinsController>(ProteinsController(),permanent: true);
    Get.put<BodyMassController>(BodyMassController(),permanent: true);
    Get.put<FillAddressController>(FillAddressController(),permanent: true);
    Get.put<PayController>(PayController(),permanent: true);
    Get.put<PageViewsController>(PageViewsController(),permanent: true);
    Get.put<AddressController>(AddressController(),permanent: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<DistanceCellingController>(() => DistanceCellingController());
    Get.lazyPut<PrivacyController>(() => PrivacyController());

    //Get.put<EditProfileController>(EditProfileController(),permanent: true);
  }

}