import 'dart:convert';
import 'package:app/base/custome_loader.dart';
import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/model/sign_up_body.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/TextFieldBuilder.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/snack_bar_message.dart';
import '../../../utils/colors.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var signUpImages = ["t.png", "f.png", "g.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return (!_authController.isLoading)?SingleChildScrollView(
          child: Column(
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
              TextFieldBuilder(
                controller: emailController,
                prefixIcon: Icons.email,
                hintText: "Email",
              ),
              TextFieldBuilder(

                controller: passwordController,
                prefixIcon: Icons.password_outlined,
                hintText: "Password",
                isObsecure: true,
              ),
              TextFieldBuilder(
                controller: nameController,
                prefixIcon: Icons.person,
                hintText: "Name",
              ),
              TextFieldBuilder(
                controller: phoneController,
                prefixIcon: Icons.phone,
                hintText: "Phone",
              ),
              signUpButton(),
              SizedBox(height: Dimension.scaleHeight(20)),
              GestureDetector(onTap:(){
                Get.back();
              },child: RichTextBuilder("Have an account already?")),
              SizedBox(
                height: Dimension.screenHeight * 0.05,
              ),

            ],
          ),
        ):Center(child: CustomLoader());
      },),
    );
  }

  Widget signUpButton() {
    return GestureDetector(
      onTap: () {
        _registration();

      },
      child: Container(
        width: Dimension.screenWidth / 2,
        height: Dimension.screenHeight / 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.scaleHeight(30)),
          color: AppColors.mainColor,
        ),
        child: Center(
          child: BigText(
            text: "Sign Up",
            size: Dimension.scaleWidth(30),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget RichTextBuilder(String text) {
    return RichText(
      text: TextSpan(
          recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
          text: text,
          style: TextStyle(
              color: Colors.grey[500], fontSize: Dimension.scaleWidth(16))),
    );
  }

  Widget signUpMethodsBuilder() {
    return Wrap(
      children: List.generate(
          3,
          (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  //  backgroundColor: Colors.white,
                  radius: Dimension.scaleWidth(30),
                  backgroundImage:
                      AssetImage("assets/image/" + signUpImages[index]),
                ),
              )),
    );
  }

  void _registration() {
    AuthController authController = Get.find();

    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (name.isEmpty) {
      showSnackBar("Type in your name ", title: "Name");
    } else if (phone.isEmpty) {
      showSnackBar("Type in your phone number", title: "Phone number");
    } else if (email.isEmpty) {
      showSnackBar("Type in your email address ", title: "email address");
    } else if (!GetUtils.isEmail(email)) {
      showSnackBar("Type in a valid email address ",
          title: "Valid email address");
    } else if (password.length < 6) {
      showSnackBar("Password can not bel less than sic characters ",
          title: "Password");
    } else {
      showSnackBar("All is perfect ", title: "Perfect");
      SignUpBody signUpBody = SignUpBody(
          name: name, phone: phone, email: email, password: password);
      authController.registration(signUpBody).then((status) {
        if (status!="") {
          print("success");
          UserController userController=Get.find();
          userController.saveUserData(jsonEncode(signUpBody));

          Get.offNamed(RouteHelper.intial);
        } else {
          showSnackBar("Failed");
        }
      });
    }
  }
}
