import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/address.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/auth_text.dart';
import 'package:new_one_life/widget/close_keyboard.dart';

class AddAddress extends StatelessWidget {
  final type;
  final List? editAddress;

  AddAddress({Key? key, this.type,this.editAddress}) : super(key: key);

  var textStyle = TextStyle(color: drawerTitleColor);
  final _formKey = GlobalKey<FormState>();

  text(text) => Text(
        text,
        style: textStyle,
      );

  var controllerList = <TextEditingController>[];


  @override
  Widget build(BuildContext context) {
    var liste = ['İsim', 'Soy İsim', 'Şehir', type + ' Adresi', 'Adres Adı','Telefon Numarası'];
    return CloseKeyboard(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.12),
          child: MyAppBar(title: 'Adres Ekle'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: Get.height * 0.1),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                    shrinkWrap: true,
                    itemCount: liste.length,
                    itemBuilder: (context, index) {
                      controllerList.add(TextEditingController());
                      if(editAddress != null){
                          controllerList[index].text = editAddress![index];
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text(liste[index]),
                          sizedBox1,
                          AuthText(
                            controller: controllerList[index],
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Bu alan boş bırakılamaz';
                              }
                            },
                          ),
                          sizedBox22
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
                  child: AuthButton(
                    text: editAddress == null ? 'Adresi Ekle': 'Adresi Güncelle',
                    onTap: () async {
                      if(_formKey.currentState!.validate()){
                        if(editAddress == null){
                          // adres ekleme
                          var adreslist = <String>[];
                          for(int i= 0; i<controllerList.length;i++){
                            adreslist.add(controllerList[i].text);
                          }
                          var result = await Get.find<UserController>().addAddress(adreslist,type);
                          if(result!){
                            Get.back(result: true);
                          }else{
                            Get.snackbar('Uyarı', 'Adres Ekleme Başarısız');
                          }
                        }else{
                          // adres güncelleme
                          var adreslist = <String>[];
                          for(int i= 0; i<controllerList.length;i++){
                            adreslist.add(controllerList[i].text);
                          }
                          var result = await Get.find<UserController>().editAddress(adreslist,type,editAddress!.last);
                          if(result!){
                            Get.back(result: true);
                          }else{
                            Get.snackbar('Uyarı', 'Adres Ekleme Başarısız');
                          }
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
