import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/drawer_pages/address/address.dart';
import 'package:new_one_life/ui/drawer_pages/profile/package_basket.dart';
import 'package:new_one_life/ui/drawer_pages/profile/product_basket.dart';
import 'package:new_one_life/ui/drawer_pages/profile/my_list.dart';
import 'package:new_one_life/ui/drawer_pages/profile/orders.dart';

class ProfileListItem extends StatelessWidget {
  List<Map> items = [
    {'title': 'Listem', 'icon': 'assets/icons/myList.png','page':MyList()},
    {'title': 'Ürün Sepetim', 'icon': 'assets/icons/myBasket.png','page':ProductBasket()},
    {'title': 'Paket Sepetim', 'icon': 'assets/icons/myBasket.png','page':PackageBasket()},
    {'title': 'Siparişlerim', 'icon': 'assets/icons/myOrder.png','page':Orders()},
    {'title': 'Adreslerim', 'icon': 'assets/icons/myAddress.png','page':Address()},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>items[index]['page']));
                //Get.to(()=>);
              },
              child: Container(
                color: profileListItemColor,
                margin: EdgeInsets.only(bottom: Get.height*0.02),
                padding: EdgeInsets.symmetric(
                    vertical: Get.height * 0.025, horizontal: Get.width * 0.08),
                child: Row(
                  children: [
                    Image.asset(items[index]['icon']),
                    sizedBoxW3,
                    Text(items[index]['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: drawerTitleColor),),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
