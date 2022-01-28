import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/auth/choose.dart';
import 'package:new_one_life/ui/splash_pages/page_view_informations.dart';
import 'package:new_one_life/widget/auth_button.dart';

class PageViewsController extends GetxController{

  RxInt _currentPage = 0.obs;
  get currentPage => _currentPage.value;
  set setCurrentPage(int value)=> _currentPage.value = value;
}

class PageViews extends GetWidget<PageViewsController>{
  static final _controller = PageController(initialPage: 0);


  final List<Widget> _pages = [
    PageViewInformations(
      title: "Lorem ipsum dolor sit amet",
      description:
          "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed",
      photo: 'assets/images/first.svg',
    ),
    PageViewInformations(
      title: 'Lorem ipsum dolor sit amet',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed',
      photo: 'assets/images/second.svg',
    ),
    PageViewInformations(
      title: 'Lorem ipsum dolor sit amet',
      description:
          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed',
      photo: 'assets/images/third.svg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.height*0.65,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onchanged,
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
          ),
          containerAnimation(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width*0.1),
            child: AuthButton(
              text: controller.currentPage != 2 ? 'İleri' : 'Hemen Başla',
              onTap: () async {
                if (controller.currentPage == 2) {
                  Get.to(() => Choose());
                } else {
                  _controller.animateToPage(controller.setCurrentPage = controller.currentPage+1, duration: Duration(milliseconds: 150), curve: Curves.easeInCirc);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget containerAnimation() {
    return Container(
      margin: EdgeInsets.only(bottom: Get.height*0.2,top: Get.height * 0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(()=> Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(3, (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: Get.height * 0.009,
                  width: (index == controller.currentPage)
                      ? Get.width * 0.05
                      : Get.width * 0.025,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (index == controller.currentPage)
                          ? mainColor
                          : animationContainerInactiveColor),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  void _onchanged(int index) {
      controller.setCurrentPage = index;
  }
}
