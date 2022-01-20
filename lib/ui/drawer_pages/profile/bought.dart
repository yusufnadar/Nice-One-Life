import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/product_box.dart';

class Bought extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(title: 'Satın Aldıklarım'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width*0.07),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListView.builder(itemCount: 2,itemBuilder: (context,index)=>ExpansionTile(
            title: Text('${index+10} Ağustos'),
            children: [
              sizedBox2,
              ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                itemBuilder: (context, index) => ProductBox(type: 'Bought',index: index, oneProduct: null,),
              ),
            ],
          )),
        ),
      ),
    );
  }

}
