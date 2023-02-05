import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';

import '../../utils/dimensionScale.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final ontap;
  final color;
  final iconColor;
  final size;
  const AppIcon(
      {required this.icon, this.ontap, this.color, this.iconColor, this.size});

  @override
  Widget build(BuildContext context) {
    //print("lets test color"+color.toString());
    return InkWell(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.only(left: Dimension.scaleHeight(4)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(30)),
            color: (color == null) ? Colors.white.withOpacity(0.7) : color,
          ),
          height: Dimension.scaleHeight(45),
          width: Dimension.scaleHeight(45),
          child: Icon(icon,
              size: size == null ? Dimension.scaleHeight(24) : size,
              color: iconColor == null ? AppColors.mainBlackColor : iconColor),
        ));
  }
}
