import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/address/address.dart';
import 'package:new_one_life/ui/drawer_pages/profile/profile.dart';

class MyAppBar extends StatelessWidget {
  final String? title;
  final bool? isHomePage;
  final bool? isAddress;

  MyAppBar({Key? key, this.title, this.isHomePage, this.isAddress}) : super(key: key);

  KeyboardVisibilityController keyboardVisibilityController =
      KeyboardVisibilityController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.03, left: Get.width * 0.06),
      child: AppBar(
        actions: [
          if (isHomePage == true)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                onPressed: () async {
                  await Get.to<String>(() =>  Profile());
                },
                icon: Icon(
                  Icons.person,
                  color: mainColor,
                  size: 34,
                ),
              ),
            )
          else
            Container()
        ],
        centerTitle: true,
        title: Text(
          title!,
          style: TextStyle(
            color: appbarTitleColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: backgroundColor,
        leading: Builder(
          builder: (context) => GestureDetector(
            onTap: () async {
              if (isHomePage == true) {
                Scaffold.of(context).openDrawer();
              } else {
                Get.back<dynamic>();
              }
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: mainColor)),
              child: Icon(
                isHomePage == true ? Icons.menu : Icons.arrow_back_outlined,
                color: mainColor,
                size: 20,
              ),
            ),
          ),
        ),
        bottom: isAddress == true
            ? TabBar(
                labelColor: Colors.red,
                indicatorColor: mainColor,
                controller: Get.find<AddressController>().tabController,
                tabs: const [
                  Tab(
                    child: Text(
                      'Teslimat Adreslerim',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Fatura Adreslerim',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
