import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';

class OnePost extends StatelessWidget {

  final photo;
  final name;
  final description;
  final userPhoto;
  final userId;

  OnePost({Key? key, this.photo, this.name, this.description, this.userPhoto,this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height*0.007),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: whiteColor,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: CachedNetworkImageProvider(userPhoto),),
              SizedBox(width: Get.width*0.04,),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    SizedBox(height: Get.height*0.02,),
                    Text(description,style: TextStyle(color: postDescriptionColor,fontSize: 13),),
                    if (photo != null) SizedBox(height: Get.height*0.01,) else Container(),
                    if (photo == null) Container() else ClipRRect(borderRadius: BorderRadius.circular(12),child: CachedNetworkImage(imageUrl: photo,)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
