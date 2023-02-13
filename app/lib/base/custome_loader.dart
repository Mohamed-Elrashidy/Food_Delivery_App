import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/auth_controller.dart';
import '../utils/colors.dart';
import '../utils/dimensionScale.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Iam printing loading state "+Get.find<AuthController>().isLoading.toString());
    return Container(
      height: Dimension.scaleHeight(100),
      width: Dimension.scaleHeight(100),
      decoration: BoxDecoration(
         borderRadius:BorderRadius.circular(Dimension.scaleHeight((100)/2))
             ,color:AppColors.mainColor
      ),
      alignment: Alignment.center,
      child:CircularProgressIndicator(color:Colors.white),
    );
  }
}
