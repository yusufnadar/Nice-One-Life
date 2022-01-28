import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/address/address.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/distance_selling.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/privacy.dart';
import 'package:new_one_life/ui/drawer_pages/profile/product_basket.dart';
import 'package:new_one_life/ui/drawer_pages/body_mass.dart';
import 'package:new_one_life/ui/drawer_pages/profile/bought.dart';
import 'package:new_one_life/ui/drawer_pages/doctors.dart';
import 'package:new_one_life/ui/drawer_pages/messages/conversations.dart';
import 'package:new_one_life/ui/drawer_pages/packages/packages.dart';
import 'package:new_one_life/ui/drawer_pages/products/products.dart';
import 'package:new_one_life/ui/drawer_pages/proteins.dart';

class DrawerPage extends StatelessWidget {
  drawerText(text, page, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => page));
              },
              child: Text(
                text,
                style: TextStyle(
                    fontSize: Get.height*0.018,
                    fontWeight: FontWeight.w500,
                    color: drawerTitleColor,),
              )),
          sizedBox5,
        ],
      );

  var drawerList = [
    {'title': 'Vücut Kitle İndeksi Hesaplama', 'page': BodyMass()},
    {'title': 'Doktorlar', 'page': Doctors()},
    {'title': 'Mesajlarım', 'page': Conversations()},
    //{'title': 'Listem', 'page': MyList()},
    {'title': 'Paketler', 'page': Packages()},
    {'title': 'Ürünler', 'page': Products()},
    //{'title': 'Sepetim', 'page': Basket()},
    //{'title': 'Siparişlerim', 'page': Orders()},
    {'title': 'Protein Değerleri', 'page': Proteins()},
    //{'title': 'Adreslerim', 'page': Address()},
    {'title': 'Satın Aldıklarım', 'page': Bought()},
    {'title': 'Gizlilik Sözleşmesi', 'page': Privacy()},
    {'title': 'Mesafeli Satış Sözleşmesi', 'page': DistanceSelling()},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(canvasColor: drawerColor),
        child: Drawer(
          child: Padding(
            padding:
                EdgeInsets.only(left: Get.width * 0.1, top: Get.height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xffD3E1FC),
                  radius: 55,
                ),
                sizedBox6,
                ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: drawerList.length,
                    itemBuilder: (context, index) => drawerText(
                        drawerList[index]['title'],
                        drawerList[index]['page'],
                        context),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
