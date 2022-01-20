import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/auth_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/auth_text.dart';
import 'package:new_one_life/widget/back_button.dart';
import 'package:new_one_life/widget/close_keyboard.dart';
import 'package:new_one_life/widget/gender_button.dart';

class RegisterController extends GetxController {
  Rxn<bool?> _gender = Rxn<bool>();
  bool? get gender => _gender.value;
  set setGender(bool? gender) => _gender.value = gender;


  Rx<bool?> _obscureText = true.obs;
  bool? get obscureText => _obscureText.value;
  set setObscureText(bool? obscureText) => _obscureText.value = obscureText;
}

class Register extends GetWidget<RegisterController> {
  final isDoctor;

  Register({Key? key, this.isDoctor}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(RegisterController());
    return CloseKeyboard(
      child: Scaffold(
        body: GetX<AuthController>(
          builder: (_) {
            if (_.isLoading == false) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      sizedBox4,
                      MyBackButton(),
                      CircleAvatar(
                        backgroundColor: Color(0xffD3E1FC),
                        radius: 70,
                      ),
                      sizedBox4,
                      AuthText(
                        hintText: 'Ad Soyad',
                        controller: nameController,
                        validator: (value){
                          if(value.length<3){
                            return 'Lütfen geçerli bir ad giriniz';
                          }else return null;
                        },
                      ),
                      sizedBox22,
                      AuthText(
                        hintText: 'Telefon No',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value){
                          if(value.length<10){
                            return 'Lütfen geçerli bir numara giriniz';
                          }else return null;
                        },
                      ),
                      sizedBox22,
                      AuthText(
                        hintText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value){
                          if(!value.contains('@')){
                            return 'Lütfen geçerli bir email giriniz';
                          }else return null;
                        },
                      ),
                      sizedBox22,
                      AuthText(
                        obscureText:authController.obscureText,
                        hintText: 'Şifre',
                        suffixIcon: GestureDetector(onTap: (){
                          authController.setObscureText = !authController.obscureText!;
                        },child: Icon(Icons.visibility)),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value){
                          if(value.length<6){
                            return 'Lütfen en az 6 karakter giriniz';
                          }else return null;
                        },
                      ),
                      sizedBox3,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GenderButton(onTap: (){
                            authController.setGender = false;
                          },text: 'Kadın',textColor: authController.gender == false ? whiteColor: genderTextColor ,buttonColor:authController.gender == false ?  genderButtonColor :whiteColor ,borderColor: authController.gender == false ?  borderColor : genderButtonBorderColor,borderWidth: authController.gender == false ? 0.5: 2.0 ),
                          sizedBoxW3,
                          GenderButton(onTap: (){
                            authController.setGender = true;
                          },text: 'Erkek',textColor: authController.gender == true ? whiteColor : genderTextColor,buttonColor:authController.gender == true ? genderButtonColor :  whiteColor,borderColor: authController.gender == true ? borderColor : genderButtonBorderColor,borderWidth: authController.gender == true ? 0.5 : 2.0),
                        ],
                      ),
                      sizedBox3,
                      loginWithGoogle(),
                      sizedBox3,
                      AuthButton(
                        text: 'Üye Ol',
                        onTap: () {
                          if(_formKey.currentState!.validate() && authController.gender != null){
                            _formKey.currentState!.save();
                            _.register(nameController.text, phoneController.text, emailController.text, passwordController.text, authController.gender, isDoctor);
                          }else{
                            Get.snackbar('Uyarı', 'Lütfen Boş Alanları Doldurunuz');
                          }
                        },
                      ),
                      sizedBox3,
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Container loginWithGoogle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: googleLoginColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 1),
          ]),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * 0.1,
          ),
          Image.asset('assets/icons/google.png'),
          SizedBox(
            width: Get.width * 0.07,
          ),
          Text(
            'Google İle Kayıt Ol',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
