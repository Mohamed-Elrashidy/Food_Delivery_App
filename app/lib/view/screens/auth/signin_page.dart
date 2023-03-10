import 'dart:convert';

import 'package:app/base/custome_loader.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/screens/auth/signup_page.dart';
import 'package:app/view/screens/home_page/home_page.dart';
import 'package:app/view/widgets/TextFieldBuilder.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/snack_bar_message.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../utils/colors.dart';
import '../../widgets/small_text.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   //
    return Scaffold(
      backgroundColor: Colors.white,
      body:GetBuilder<AuthController>(builder:(_authController){
        return !_authController.isLoading? SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    padding: EdgeInsets.only(top: Dimension.scaleHeight(50)),
                    child: ClipRRect(
                        borderRadius:
                        BorderRadius.circular(Dimension.scaleWidth(150)),
                        child: Image.asset(
                          "assets/image/logo part 1.png",
                          fit: BoxFit.cover,
                          height: Dimension.scaleWidth(170),
                          width: Dimension.scaleWidth(170),
                        ))),
              ),
              welcomeTextBuilder(),
              TextFieldBuilder(
                controller: emailController,
                prefixIcon: Icons.email,
                hintText: "Email",
              ),
              TextFieldBuilder(
                  controller: passwordController,
                  prefixIcon: Icons.password_outlined,
                  hintText: "Password",
                  isObsecure:true
              ),
              Row(
                children: [
                  Expanded(child: Container()),
                  SmallText(text: "Sign into your account"),
                  SizedBox(
                    width: Dimension.scaleWidth(20),
                  )
                ],
              ),
              SizedBox(height: Dimension.scaleHeight(20)),
              signInButton(),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),
              makeNewAccount(),
              SizedBox(height: Dimension.scaleWidth(20)),
            ],
          ),
        ):Center(child: CustomLoader());
      }),
    );
  }

  Widget signInButton() {
    return GestureDetector(
      onTap: (){_login();},
      child: Container(
        width: Dimension.screenWidth / 2,
        height: Dimension.screenHeight / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.scaleHeight(30)),
          color: AppColors.mainColor,
        ),
        child: Center(
          child: BigText(
            text: "Sign In",
            size: Dimension.scaleWidth(30),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget makeNewAccount() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: Dimension.scaleWidth(100),),
        SmallText(text: "Don\'t hava an account?"),
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.singUpPage);
          },
          child: Text(
            "Create",
            style: TextStyle(
                fontSize: Dimension.scaleWidth(16),
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget welcomeTextBuilder() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(
                  fontSize: Dimension.scaleHeight(60),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: Dimension.scaleHeight(10),
            ),
            SmallText(
              text: "Sign into your account",
              size: Dimension.scaleHeight(18),
            ),
            Row(
              children: [Expanded(child: Container())],
            )
          ],
        ));
  }
  void _login() {
    AuthController authController = Get.find();

    String email = emailController.text.trim();
    String password = passwordController.text.trim();
   if (email.isEmpty) {
      showSnackBar("Type in your email address ", title: "email address");
    } else if (!GetUtils.isEmail(email)) {
      showSnackBar("Type in a valid email address ",
          title: "Valid email address");
    } else if (password.length < 6) {
      showSnackBar("Password can not bel less than sic characters ",
          title: "Password");
    } else {
      showSnackBar("All is perfect ", title: "Perfect");

      authController.login(email,password).then((status) {
        if (status!="") {
          print("success");
          authController.getUserData(email);
          Get.find<UserController>().initUserData();
          Get.toNamed(RouteHelper.intial);
        } else {
          showSnackBar("faild");
        }
      });
    }
  }

}
