import 'package:app/model/product.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/data_view.dart';

class PopularFoodDetails extends StatelessWidget {
   PopularFoodDetails({Key? key}) : super(key: key);
ProductModel productModel=ProductModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: Stack(
        children: [
          imagePosition(),
          dataView(),
          titleWidgets(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBarBuilder(),
    );
  }
  Widget bottomNavigationBarBuilder()
  {
    return Container(
      decoration: BoxDecoration(
        //  color:Color.fromARGB(16, 217, 217, 222),
      //  color:AppColors.textColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.scaleHeight(20)),
            topRight: Radius.circular(Dimension.scaleHeight(20))),
        // color: Colors.black12,
      ),
      padding: EdgeInsets.symmetric(
          vertical: Dimension.scaleHeight(20),
          horizontal: Dimension.scaleWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(Dimension.scaleHeight(24))),
              child: Row(
                children: [
                  InkWell(
                      child: Container(
                        color: Colors.black45,
                        height: Dimension.scaleHeight(2),
                        width: Dimension.scaleWidth(13),
                      )),
                  SizedBox(width: Dimension.scaleWidth(10)),
                  BigText(text: '1', size: Dimension.scaleHeight(24)),
                  SizedBox(
                    width: Dimension.scaleWidth(10),
                  ),
                  InkWell(
                      child: Icon(Icons.add,
                          color: Colors.black45,
                          size: Dimension.scaleHeight(24)))
                ],
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Dimension.scaleHeight(20),
                  horizontal: Dimension.scaleWidth(20))),
          Container(
              padding: EdgeInsets.symmetric(
                  vertical: Dimension.scaleHeight(20),
                  horizontal: Dimension.scaleWidth(15)),
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius:
                  BorderRadius.circular(Dimension.scaleHeight(20))),
              child: BigText(text: "\$0.8 Add To Cart"))
        ],
      ),
    );
  }
  Widget imagePosition() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: Dimension.scaleHeight(230),
        child: Container(
          width: double.infinity,
          child: Image.asset(
            "assets/image/food0.png",
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget titleWidgets() {
    return Positioned(
      left: Dimension.scaleWidth(10),
      top: Dimension.scaleHeight(40),
      right: Dimension.scaleWidth(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIcon(icon:Icons.arrow_back_ios),
          AppIcon(icon:Icons.shopping_cart)
        ],
      ),
    );
  }


  Widget dataView() {
    return Positioned(
      top: Dimension.scaleHeight(280),
      bottom: 0,
      child: Container(
        width: Dimension.screenWidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Dimension.scaleHeight(16))),
        child: Column(
          children: [
            Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: Dimension.scaleHeight(10),
                      horizontal: Dimension.scaleWidth(20),
                    ),
                    child: DataView(productModel))),
          ],
        ),
      ),
    );
  }
}
