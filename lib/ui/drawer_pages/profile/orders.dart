import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/product_box.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(title: 'Siparişlerim'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetX<UserController>(
            initState: (func) {
              func.controller!.getOrders();
            },
            builder: (_) => ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => ExpansionTile(
                title: Text('${index + 10} Ağustos'),
                children: [
                  sizedBox2,
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                    itemBuilder: (context, index) =>
                        ProductBox(type: 'Order', index: index),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
