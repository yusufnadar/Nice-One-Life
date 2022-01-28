import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class UserPdf extends StatelessWidget {
  final userCv;

  UserPdf({Key? key, this.userCv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: MyAppBar(title: 'CV'),
      ),
      body: Container(
        child: userCv != null && userCv != '' ? SfPdfViewer.network(userCv) : Center(child: Text('Bu kullanıcının henüz cvsi yok'),),
      ),
    );
  }
}
