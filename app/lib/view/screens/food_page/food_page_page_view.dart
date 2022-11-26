import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:app/view/widgets/text_and_icon.dart';
import 'package:flutter/material.dart';

import '../../widgets/bit_text.dart';

class FoodPageViewWidget extends StatelessWidget {
  PageController pageController=PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
        itemBuilder: (_, index) => Container(
          padding: EdgeInsets.all(8),
         // color: Colors.red,
          height: 320,
          child: Stack(
            children: [
              photoWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: dataWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget photoWidget() {
    return Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              "assets/image/food0.png",
              fit: BoxFit.cover,
            )));
  }

  Widget dataWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      height: 120,
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Chineese food",
          ),
          SizedBox(height: 12,),
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
              SizedBox(width: 10,),
              SmallText(text: "4.5"),
              SizedBox(width: 10,),
              SmallText(text: "1278 comments"),

            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            TextAndIconWidget(color: AppColors.iconColor1, text: "Normal", icon: Icons.circle),
            TextAndIconWidget(color: AppColors.mainColor, text: "1.7Km", icon: Icons.location_on_rounded),
            TextAndIconWidget(color: AppColors.iconColor2, text: "32min", icon: Icons.access_time),


          ],)
          
        ],
      ),
    );
  }
}
