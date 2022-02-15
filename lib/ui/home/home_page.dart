// ignore_for_file: must_be_immutable
<<<<<<< HEAD
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
=======
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_one_life/controllers/data_controller.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/post.dart';
import 'package:new_one_life/ui/home/drawer.dart';
import 'package:new_one_life/ui/post/add_post.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/one_post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePageController extends GetxController {
  RxBool _getMore = true.obs;
  get getMore => _getMore.value;
  set setgetMore(bool value)=> _getMore.value = value;

  RxBool _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set setisLoading(bool value)=> _isLoading.value = value;
}

class HomePage extends GetWidget<HomePageController> {
<<<<<<< HEAD
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
=======
  RefreshController _refreshController = RefreshController(initialRefresh: false);
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      drawer: DrawerPage(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.11),
        child: MyAppBar(
          title: 'NİCE ONE LİFE',
          isHomePage: true,
        ),
      ),
      floatingActionButton: floatingActionButton(),
      body: GetX<DataController>(
        init: DataController(),
        initState: (func) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            func.controller!.getPosts();
            userId = Get.find<UserController>().user.id;
          });
        },
        builder: (_) {
          if (controller.isLoading) {
            return Center(child: Lottie.asset('assets/lottie/loading.json'));
          } else {
            if (_.posts!.isNotEmpty) {
              return SmartRefresher(
                enablePullDown: true,
                enablePullUp: controller.getMore == true ? true : false,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
<<<<<<< HEAD
                footer: const ClassicFooter(
                    noMoreIcon: Icon(Icons.add),
                    loadStyle: LoadStyle.ShowWhenLoading),
                header: const ClassicHeader(
=======
                footer: ClassicFooter(
                    noMoreIcon: Icon(Icons.add),
                    loadStyle: LoadStyle.ShowWhenLoading),
                header: ClassicHeader(
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                  refreshStyle: RefreshStyle.UnFollow,
                  completeText: 'Güncellendi',
                  refreshingText: 'Güncelleniyor',
                ),
                child: ListView.builder(
                  itemCount: _.posts!.length,
                  itemBuilder: (context, index) {
                    PostModel post = _.posts![index];
                    return OnePost(
                      userPhoto: post.userPhoto,
                      name: post.name,
                      description: post.description,
                      photo: post.photo,
                      userId: post.userId,
                    );
                  },
                ),
              );
            } else {
<<<<<<< HEAD
              return const Center(
=======
              return Center(
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
                child: Text('Henüz Post Paylaşılmamış'),
              );
            }
          }
        },
      ),
    );
  }

<<<<<<< HEAD

=======
>>>>>>> f7da5cf2bd87b2af8afff7f59f53115c7e68e721
  Container floatingActionButton() {
    return Container(
      margin:
          EdgeInsets.only(bottom: Get.height * 0.05, right: Get.width * 0.04),
      child: FloatingActionButton(
        backgroundColor: mainColor,
        onPressed: () {
          Get.to(() => AddPost());
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  void _onRefresh() async {
    controller.setgetMore = true;
    await Get.find<DataController>().getPosts();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (controller.getMore) {
      await Get.find<DataController>().getMorePosts();
    }
    _refreshController.loadComplete();
  }
}
