import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:app/view/widgets/text_and_icon.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../../utils/dimensionScale.dart';
import '../../widgets/bit_text.dart';

class FoodPageViewWidget extends StatefulWidget {
  @override
  State<FoodPageViewWidget> createState() => _FoodPageViewWidgetState();
}

class _FoodPageViewWidgetState extends State<FoodPageViewWidget> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    return Column(
      children: [
        SizedBox(
          height: Dimension.scaleHeight(250.0),
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (_, index) => Container(
                padding: EdgeInsets.all(Dimension.scaleWidth(8.0)),
                // color: Colors.red,

                child: itemBuilder(index)),
          ),
        ),
        SizedBox(height: Dimension.scaleHeight(15),),
        dotsView()
      ],
    );
  }

  Widget itemBuilder(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (_currPageValue.floor() == index) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = 220 * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = 220 * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else
      matrix = Matrix4.diagonal3Values(1, 0.8, 1)..setTranslationRaw(0, 22, 0);
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          photoWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: dataWidget(),
          )
        ],
      ),
    );
  }

  Widget photoWidget() {
    return Container(
        height: Dimension.scaleHeight(160),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(20.0))),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(20.0)),
            child: Image.asset(
              "assets/image/food0.png",
              fit: BoxFit.cover,
              cacheHeight:Dimension.scaleHeight(160).ceil() ,

            )));
  }
  Widget dotsView()
  {
    return DotsIndicator(
        dotsCount: 5,
        position: _currPageValue,
        decorator: DotsDecorator(
        size: const Size.square(9.0),
    activeSize: const Size(18.0, 9.0),
    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    ),
    );
  }

  Widget dataWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.scaleHeight(16.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xFFe8e8e8), blurRadius: 5, offset: Offset(0, 5)),
            BoxShadow(
                color: Colors.white, blurRadius: 5, offset: Offset(-5, 0)),
            BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(5, 0))
          ]),
      height: Dimension.scaleHeight(100.0),
      //width:Dimension.scaleWidth(320),
      margin: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(15.0)),
      padding: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(15.0), vertical: Dimension.scaleHeight(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "Chineese food",
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
          )
        ],
      ),
    );
  }
}
