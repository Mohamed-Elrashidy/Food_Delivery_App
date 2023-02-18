import 'package:app/base/snack_bar_message.dart';
import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/location_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<UserController>().initUserData();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      body: GetBuilder<UserController>(
        builder: (userConroller) {
          return _userLoggedIn
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppBarBuilder(),
                      SizedBox(
                        height: Dimension.scaleHeight(20),
                      ),
                      dataViewBuilder()
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: Dimension.scaleHeight(160),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.scaleWidth(20)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/signintocontinue.png"))),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.offNamed(RouteHelper.singInPage);
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimension.scaleHeight(100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimension.scaleWidth(20)),
                              color: AppColors.mainColor),
                          child: Center(
                            child: BigText(
                              text: "Sign in ",
                              color: Colors.white,
                              size: Dimension.scaleWidth(30),
                            ),
                          ),
                        ))
                  ],
                ));
        },
      ),
    );
  }

  Widget AppBarBuilder() {
    return Container(
        padding: EdgeInsets.only(top: Dimension.scaleHeight(20)),
        height: Dimension.scaleHeight(80),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Center(
            child: BigText(text: "Profile", size: Dimension.scaleHeight(28))));
  }

  Widget photoBuilder() {
    return CircleAvatar(
      radius: Dimension.scaleWidth(80),
      backgroundColor: AppColors.mainColor,
      child: Icon(
        Icons.person,
        size: 100,
        color: Colors.white,
      ),
    );
  }

  Widget dataViewBuilder() {
    UserController _userController = Get.find<UserController>();
    return Column(
      children: [
        photoBuilder(),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            _userController.userMOdel.name),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.phone,
              color: Colors.yellow,
            ),
            _userController.userMOdel.phone),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.email,
              color: Colors.yellow,
            ),
            _userController.userMOdel.email),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
       GetBuilder<LocationController>(builder: (locationConroller){
         if(Get.find<AuthController>().userLoggedIn()) {
           locationConroller.getAddressList(Get.find<UserController>().userMOdel.email);

         }
         print(locationConroller.addressList.length);
         if(Get.find<AuthController>().userLoggedIn()&&locationConroller.addressList.length>0)
           {
             return InkWell(
               onTap: (){
                 Get.toNamed(RouteHelper.addressRoute);
               },
               child: dataItemBuilder(
                   AppIcon(
                     icon: Icons.location_on_rounded,
                     color: Colors.yellow,
                   ),
                   "Your address"),
             );
           }
         else if(Get.find<AuthController>().userLoggedIn())
           {
             return InkWell(
               onTap: (){
                 Get.toNamed(RouteHelper.addressRoute);

               },
               child: dataItemBuilder(
                   AppIcon(
                     icon: Icons.location_on_rounded,
                     color: Colors.yellow,
                   ),
                   "Fill in your address"),
             );
           }
         else
           {
             return InkWell(
               onTap: (){
                 Get.toNamed(RouteHelper.singInPage);
               },
               child: dataItemBuilder(
                   AppIcon(
                     icon: Icons.location_on_rounded,
                     color: Colors.yellow,
                   ),
                   "Fill in your address"),
             );
           }

       },),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.message,
              color: Colors.redAccent,
            ),
            "Messages"),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        GestureDetector(
          onTap: () {
            if (Get.find<AuthController>().userLoggedIn()) {
              print('loggedout');
              Get.find<AuthController>().clearSharedData();
              Get.find<CartController>().clearCartHistory();
              Get.offNamed(RouteHelper.singInPage);
            } else {
              showSnackBar("you are not login");
            }
          },
          child: dataItemBuilder(
              AppIcon(
                icon: Icons.logout,
                color: Colors.redAccent,
              ),
              "LogOut"),
        ),
        SizedBox(
          height: Dimension.scaleHeight(20),
        ),
      ],
    );
  }

  Widget dataItemBuilder(AppIcon appIcon, text) {
    return Container(
      height: Dimension.scaleHeight(70),
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset.zero, blurRadius: 2, color: Colors.white)
      ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: appIcon,
          ),
          SizedBox(
            width: 10,
          ),
          BigText(
            text: text,
            size: 18,
          )
        ],
      ),
    );
  }
}
