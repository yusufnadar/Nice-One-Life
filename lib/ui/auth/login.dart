import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/auth_controller.dart';
import 'package:new_one_life/default/boxes.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/ui/auth/forgot_password.dart';
import 'package:new_one_life/ui/auth/register.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:new_one_life/widget/auth_button.dart';
import 'package:new_one_life/widget/auth_text.dart';
import 'package:new_one_life/widget/back_button.dart';
import 'package:new_one_life/widget/close_keyboard.dart';

class LoginController extends GetxController{
  Rx<bool?> _obscureText2 = true.obs;
  bool? get obscureText2 => _obscureText2.value;
  set setObscureText2(bool? obscureText2) => _obscureText2.value = obscureText2;
}

class Login extends StatelessWidget {

  final isDoctor;

  Login({Key? key, this.isDoctor}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
    var authController = Get.put(AuthController());
    return CloseKeyboard(
      child: Scaffold(
        body: GetX<AuthController>(builder: (_){
          if(!_.isLoading){
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.07),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    sizedBox10,
                    MyBackButton(),
                    CircleAvatar(
                      backgroundColor: Color(0xffD3E1FC),
                      radius: 70,
                    ),
                    sizedBox6,
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
                    sizedBox2,
                    AuthText(
                      obscureText:loginController.obscureText2,
                      hintText: 'Şifre',
                      suffixIcon: GestureDetector(onTap: (){
                        loginController.setObscureText2 = !loginController.obscureText2!;
                      },child: Icon(Icons.visibility)),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value){
                        if(value.length<6){
                          return 'Lütfen en az 6 karakter giriniz';
                        }else return null;
                      },
                    ),
                    forgotPassword(),
                    AuthButton(
                      text: 'Giriş Yap',
                      onTap: () async {
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          await authController.login(emailController.text,passwordController.text);
                        }
                      },
                    ),
                    sizedBox3,
                    orLogin(),
                    sizedBox22,
                    loginWithGoogle(),
                    sizedBox10,
                    orRegister(),
                    sizedBox3,
                  ],
                ),
              ),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }

  Align forgotPassword() => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Get.to(()=>ForgotPassword());
          },
          child: Text(
            'Şifremi Unuttum',
            style: TextStyle(color: chooseTextColor),
          ),
        ),
      );

  Text orRegister() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'Hesabınız yok mu? '),
          TextSpan(
            text: 'Üye OL',
            style: TextStyle(
              color: Color(0xff21899C),
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.to(() => Register(isDoctor:isDoctor));
              },
          ),
        ],
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
            'Google İle Giriş Yap',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Row orLogin() {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: hintTextColor,
            height: 1,
          ),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Text(
          'veya ile giriş yapın',
          style: TextStyle(
            color: hintTextColor,
          ),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: hintTextColor,
            height: 1,
          ),
        ),
      ],
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/colors.dart';
import 'package:new_one_life/models/message.dart';
import 'package:new_one_life/models/push_notification_entity.dart';
import 'package:new_one_life/services/notification_service/notification_handler1.dart';
import 'package:new_one_life/widget/app_bar.dart';
import 'package:new_one_life/widget/message_container.dart';

class Messages extends GetWidget<UserController> {
  final userId;

  Messages({Key? key,this.userId}) : super(key: key);

  final textController = TextEditingController();

  ScrollController _scrollController = ScrollController();

  void _listeScrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      Get.find<UserController>()
          .getMoreMessages(userId, Get.find<UserController>().user.id);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: Obx(()=> MyAppBar(
            title: controller.otherUser.name != null ? controller.otherUser.name : ''
        )),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
                stream:
                controller.getMessages(userId, controller.user.id),
                builder: (BuildContext context, snapshot) {
                      return GetX<UserController>(
                        init: UserController(),
                        initState: (func) {
                          getUserWithId();
                          _scrollController.addListener(_listeScrollListener);
                        },
                        dispose: (aa){
                          controller.otherUser.name = null;
                        },
                        builder: (_){
                          if(!snapshot.hasData){
                            return Center(
                              child: controller.user.name != null ? CircularProgressIndicator() : CircularProgressIndicator()
                            );
                          }else{
                            if(snapshot.data!.isEmpty){
                              return Center(child: Text('Henüz Mesaj Yok'),);
                            }else{
                              controller.messages!.clear();
                              controller.messages!.addAll(snapshot.data!);
                              return ListView.builder(
                                controller: _scrollController,
                                reverse: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06),
                                itemCount: _.messages!.length,
                                itemBuilder: (context, index) {
                                  return MessageContainer(
                                      isMe: _.messages![index].fromId == _.user.id
                                          ? false
                                          : true,
                                      messageModel: _.messages![index]);
                                },
                              );
                            }
                          }
                        },
                      );

                }),
          ),
          sendMessageButton(),
        ],
      ),
    );
  }

  sendMessageButton() {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.02),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.06, vertical: Get.height * 0.02),
        decoration: BoxDecoration(
            color: sendMessageContainerColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none),
              controller: textController,
            )),
            GestureDetector(
                onTap: () async {
                  if(_scrollController.hasClients){
                    _scrollController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  }
                    controller.addMessage(textController.text, userId,
                        Get.find<UserController>().user.id);
                  final pushNotification = PushNotificationEntity();
                  pushNotification.title = controller.user.name;
                  pushNotification.body = textController.text;
                  pushNotification.token = controller.otherUser.fcmToken;
                  pushNotification.userId = controller.user.id;
                  final notification = NotificationHandler1();
                  await notification.sendNotification(pushNotificationEntity: pushNotification);
                  textController.clear();
                },
                child: Image.asset('assets/icons/Send.png'))
          ],
        ),
      ),
    );
  }

  Future<void> getUserWithId() async{
    await controller.getUserWithId(userId);
  }

}

 */
