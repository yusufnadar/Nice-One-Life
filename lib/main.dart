import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:new_one_life/controllers/bindings/all_binding.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/default/initialize/notification_initialize.dart';
import 'package:new_one_life/default/theme.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/ui/splash_pages/landing_page.dart';

void main() async {
  await Initialize.initializing();
  initializeDateFormatting('tr');
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nice One Life',
      builder: (context, child) =>
          ScrollConfiguration(behavior: MyBehavior(), child: child!),
      debugShowCheckedModeBanner: false,
      initialBinding: AllBindings(),
      theme: ThemeDatas.themeData(),
      locale: Get.deviceLocale,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/home_page', page: () => HomePage()),
        GetPage(name: '/', page: () => LandingPage())
      ],
    );
  }
}
