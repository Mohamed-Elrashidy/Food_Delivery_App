import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../widgets/app_icon.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
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
      ),

    );
  }

  Widget AppBarBuilder() {
    return Container(
        padding: EdgeInsets.only(top: Dimension.scaleHeight(30)),
        height: Dimension.scaleHeight(100),
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.mainColor),
        child: Center(
            child: BigText(text: "Profile", size: Dimension.scaleHeight(28))));
  }

  Widget photoBuilder() {
    return CircleAvatar(
      radius: Dimension.scaleWidth(100),
      backgroundColor: AppColors.mainColor,
      child: Icon(
        Icons.person,
        size: 100,
        color: Colors.white,
      ),
    );
  }

  Widget dataViewBuilder() {
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
            "text"), SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text") ,SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text") ,SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text"), SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text"), SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text"), SizedBox(
          height: Dimension.scaleHeight(20),
        ),
        dataItemBuilder(
            AppIcon(
              icon: Icons.person,
              color: AppColors.mainColor,
            ),
            "text")
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
          BigText(text: text)
        ],
      ),
    );
  }
}
