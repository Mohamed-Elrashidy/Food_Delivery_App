import 'package:app/controller/popular_product_controller.dart';
import 'package:app/model/product.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:app/view/widgets/text_and_icon.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/dimensionScale.dart';
import '../../widgets/bit_text.dart';
import '../../widgets/data_view.dart';

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
      GetBuilder<PopularProductController>(builder: (popularProducts)
      {
        return         popularProducts.isLoaded?SizedBox(
          height: Dimension.scaleHeight(250.0),
          child: PageView.builder(
            controller: pageController,
            itemCount: popularProducts.popularProductList.length,
            itemBuilder: (_, index) => Container(
                padding: EdgeInsets.all(Dimension.scaleWidth(8.0)),
                // color: Colors.red,

                child: itemBuilder(index,popularProducts.popularProductList[index])),
          ),
        ):CircularProgressIndicator();

      }),
        SizedBox(height: Dimension.scaleHeight(15),),
        dotsView()
      ],
    );
  }

  Widget itemBuilder(int index,ProductModel popularProduct) {
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
          photoWidget(AppConstants.BASE_URI+"/uploads/"+popularProduct.img!),
          Align(
            alignment: Alignment.bottomCenter,
            child: dataWidget(popularProduct),
          )
        ],
      ),
    );
  }

  Widget photoWidget(String imgUri) {
    return Container(
        height: Dimension.scaleHeight(160),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(20.0))),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(20.0)),
            child: Image.network(
              imgUri,
              fit: BoxFit.cover,
              cacheHeight:Dimension.scaleHeight(160).ceil() ,

            )));
  }
  Widget dotsView()
  {
    return GetBuilder<PopularProductController>(builder: (popularProduct)
    {
      return DotsIndicator(
        dotsCount: popularProduct.popularProductList.length<=0?1:popularProduct.popularProductList.length,
        position: _currPageValue,
        decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      );
    });
  }

  Widget dataWidget(ProductModel productModel) {
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
      child: DataView(productModel),
    );
  }
}
