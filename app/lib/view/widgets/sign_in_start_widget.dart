import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensionScale.dart';
import 'bit_text.dart';

class SignInStartWidget extends StatelessWidget {
  const SignInStartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
          )) ,
    );
  }
}
