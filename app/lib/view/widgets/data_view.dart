import 'package:app/view/widgets/small_text.dart';
import 'package:app/view/widgets/text_and_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';
import '../../utils/colors.dart';
import '../../utils/dimensionScale.dart';
import 'bit_text.dart';
import 'expandable_text_widget.dart';

class DataView extends StatelessWidget {
  ProductModel productModel;
   DataView(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Container(
     // margin: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(15.0)),
      //padding: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(15.0), vertical: Dimension.scaleHeight(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: productModel.name!,
          ),
          SizedBox(
            height: Dimension.scaleHeight(8.0),
          ),
          Row(
            children: [
              SizedBox(
                width: 75,
                height: 15,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (_, index) =>
                        Icon(Icons.star, color: AppColors.mainColor, size: 15)),
              ),
              SizedBox(
                width: Dimension.scaleHeight(5.0),
              ),
              SmallText(text: "4.5"),
              SizedBox(
                width: Dimension.scaleWidth(8.0),
              ),
              SmallText(text: "1278 comments"),
            ],
          ),
          SizedBox(
            height: Dimension.scaleHeight(13.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextAndIconWidget(
                  color: AppColors.iconColor1,
                  text: "Normal",
                  icon: Icons.circle),
              TextAndIconWidget(
                  color: AppColors.mainColor,
                  text: "1.7Km",
                  icon: Icons.location_on_rounded),
              TextAndIconWidget(
                  color: AppColors.iconColor2,
                  text: "32min",
                  icon: Icons.access_time),
            ],
          ),
      //ExpandableTextWidget(text:"dskajfkdjfklasjdfkasjf;klasjfkasjfskdfjaskjfsdkjfskldjfskldfjakljfsklfjaskljfskldfjskjfklsjfskldjfksdjfiwejrioefskdckwefjifjklsfjiejfkldsfnmaweiofjwkfnweiofjoiefjainofefua")
      ],
      ),
    );
  }
}
