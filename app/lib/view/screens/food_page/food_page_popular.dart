import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../widgets/text_and_icon.dart';

class FoodPagePopular extends StatelessWidget {
  const FoodPagePopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        listWidget(),
      ],
    );
  }
  Widget titleWidget()
  {
   return Padding(
     padding:  EdgeInsets.only(left: Dimension.scaleWidth(10)),
     child: Row(
       crossAxisAlignment: CrossAxisAlignment.end,
       children: [
         BigText(text: 'Popular'),
         SizedBox(width: Dimension.scaleWidth(10),),
         Container(
             margin:EdgeInsets.only(bottom:3),
             child: SmallText(text: '.')),
         SizedBox(width: Dimension.scaleWidth(10),),
         Container(
             margin: EdgeInsets.only(bottom: 3),
             child: SmallText(text: 'Food pairing'))

       ],
     ),
   ) ;
  }
  Widget listWidget()
  {
    return ListView.builder(
      physics:NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_,index)=>Container(
          margin: EdgeInsets.symmetric(vertical: (Dimension.scaleHeight(10)), horizontal: Dimension.scaleWidth(10)),
          child:Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimension.scaleHeight(20)),
                child: Image.asset("assets/image/food0.png",
                  fit: BoxFit.cover,
                   width: Dimension.scaleWidth(150),
                   height: Dimension.scaleWidth(150),
                  cacheWidth:  (Dimension.scaleWidth(150).ceil()),
                  cacheHeight:  (Dimension.scaleWidth(150).ceil()),

                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(Dimension.scaleHeight(10)),
                  decoration: BoxDecoration(
                      color:Colors.white,

                      borderRadius: BorderRadius.circular(16)),
                  height: Dimension.scaleHeight(120),
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "Nutrition Fruit Meal in glass bottle"),
                        SmallText(text: "with chinees charctristics"),
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
                        )
                      ],
                    ),
                  )
                ),
              )
            ],
          )
        ));

  }
}
