import 'package:app/controller/cart_controller.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controller/recommended_product_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensionScale.dart';
import 'app_icon.dart';

class AppBarWidgets extends StatelessWidget {
  const AppBarWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecommendedProductController recommendedProductControl=Get.find();
         return GetBuilder< CartController>(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIcon(
            icon: Icons.arrow_back_ios,
            ontap: () {
              Get.back();
            },
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              AppIcon(icon: Icons.shopping_cart),
              (recommendedProductControl.totatItems != 0)
                  ? CircleAvatar(
                maxRadius: Dimension.scaleWidth(10),
                child: SmallText(
                  text: recommendedProductControl.totatItems.toString(),
                  size: 10,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.mainColor,
              )
                  : Container()
            ],
          )
        ],
      );
    });
    ;
  }
}
