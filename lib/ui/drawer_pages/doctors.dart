import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/user.dart';
import 'package:new_one_life/ui/drawer_pages/messages/messages.dart';
import 'package:new_one_life/ui/user_pdf.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/loading_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class DoctorsController extends GetxController {
  RxBool _getMore = true.obs;
  get getMore => _getMore.value;
  set setgetMore(bool value)=> _getMore.value = value;


  RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set setisLoading(bool value)=> _isLoading.value = value;
}

class Doctors extends GetWidget<DoctorsController> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(title: 'Doktorlar'),
      ),
      body: GetX<DataController>(
        init: DataController(),
        initState: (cont){
          cont.controller!.getDoctors();
        },
        builder: (_){
          if(controller.isLoading){
            return LoadingScreen();
          }else{
            if(_.doctors!.isEmpty){
              return Center(
                child: Text('Henüz Üye Olan Doktor Yok'),
              );
            }else{
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: controller.getMore == true ? true : false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                footer: ClassicFooter(
                    noMoreIcon: Icon(Icons.add),
                    loadStyle: LoadStyle.ShowWhenLoading),
                header: ClassicHeader(
                  refreshStyle: RefreshStyle.UnFollow,
                  completeText: 'Güncellendi',
                  refreshingText: 'Güncelleniyor',
                ),
                child: GridView.builder(
                  itemCount: _.doctors!.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.06, vertical: Get.height * 0.01),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 30,
                      childAspectRatio: 0.64),
                  itemBuilder: (context, index) => oneDoctor(index,_.doctors!),
                ),
              );
            }
          }
        },
      ),
    );
  }

  Container oneDoctor(int index, List<UserModel> doctors) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: CachedNetworkImage(imageUrl: doctors[index].userPhoto,)),
          sizedBox2,
          Text(
            doctors[index].name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          sizedBox2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              row('person', 'Cv Gör',false,doctors[index]),
              row('mail', 'Mesaj',true,doctors[index]),
            ],
          )
        ],
      ),
    );
  }

  row(icon, title,isMessage, UserModel user) {
    return GestureDetector(
      onTap: (){
        if(isMessage){
          Get.to(() => Messages(userId:user.id));
        }else{
          Get.to(()=>UserPdf(userCv:user.cv));
        }
      },
      child: Row(
        children: [
          Image.asset('assets/icons/$icon.png'),
          sizedBoxW1,
          Text(
            title,
            style: TextStyle(
                color: mainColor, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _onRefresh() async {
    controller.setgetMore = true;
    await Get.find<DataController>().getDoctors();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (controller.getMore) {
      await Get.find<DataController>().getMoreDoctors();
    }
    _refreshController.loadComplete();
  }
}
