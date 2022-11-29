import 'package:flutter/material.dart';

import '../../utils/colors.dart';

import '../../utils/dimensionScale.dart';

class AppIcon extends StatelessWidget {
 final IconData icon;
  const AppIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        child: Container(
          padding: EdgeInsets.only(left: Dimension.scaleHeight(4)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(30)),
            color: Colors.white.withOpacity(0.7),
          ),
          height: Dimension.scaleHeight(45),
          width: Dimension.scaleHeight(45),
          child: Icon(icon, size: Dimension.scaleHeight(20),color:AppColors.mainBlackColor),
        ));
  }
}
