import 'package:app/controller/cart_controller.dart';
import 'package:app/model/product.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/app_bar_widgets.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/recommended_product_controller.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/data_view.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetails extends StatelessWidget {
  List<dynamic> data = Get.arguments;
  PopularFoodDetails();
  ProductModel productModel = ProductModel();
  var recommendProductControl = Get.find<RecommendedProductController>();
  CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    //Get.find<RecommendedProductController>().init(productModel,Get.find<CartController>());
    productModel = data[0];
    recommendProductControl.init(productModel, cartController);

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

  Widget bottomNavigationBarBuilder() {
    return GetBuilder<RecommendedProductController>(
        builder: (recommendProductControl) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.scaleHeight(10)),
                    topRight: Radius.circular(Dimension.scaleHeight(10))),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Dimension.scaleHeight(10),
                  horizontal: Dimension.scaleWidth(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimension.scaleHeight(16))),
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                recommendProductControl.setQuantity(false);
                              },
                              child: Container(
                                //color: Colors.black45,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.black45,
                                  size: Dimension.scaleWidth(28),
                                ),
                              )),
                          SizedBox(width: Dimension.scaleWidth(8)),
                          GetBuilder<CartController>(builder: (_)=>BigText(
                              text: (recommendProductControl.cartItem +
                                  recommendProductControl.quantity)
                                  .toString(),
                              size: Dimension.scaleHeight(24))),
                          SizedBox(
                            width: Dimension.scaleWidth(8),
                          ),
                          InkWell(
                              onTap: () {
                                recommendProductControl.setQuantity(true);
                              },
                              child: Icon(Icons.add,
                                  color: Colors.black45,
                                  size: Dimension.scaleHeight(24)))
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimension.scaleHeight(10),
                          horizontal: Dimension.scaleWidth(10))),
                  InkWell(
                    onTap: () {
                      cartController.addItem(
                          productModel, recommendProductControl.quantity);
                      recommendProductControl.setZero(
                          cartController, productModel);
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimension.scaleHeight(20),
                            horizontal: Dimension.scaleWidth(15)),
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                                Dimension.scaleHeight(20))),
                        child: BigText(
                            text: "\$${productModel.price} | Add To Cart")),
                  )
                ],
              ),
            ));
  }

  Widget imagePosition() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: Dimension.scaleHeight(230),
        child: Container(
          width: double.infinity,
          child: Image.network(
            AppConstants.BASE_URI + AppConstants.UPLOAD_URL + productModel.img!,
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget titleWidgets() {
    return GetBuilder<RecommendedProductController>(builder: (_) {
      return Positioned(
        left: Dimension.scaleWidth(10),
        top: Dimension.scaleHeight(40),
        right: Dimension.scaleWidth(10),
        child: AppBarWidgets(),
      );
    });
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
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                      height: Dimension.scaleHeight(100),
                      padding: EdgeInsets.symmetric(
                        vertical: Dimension.scaleHeight(10),
                        horizontal: Dimension.scaleWidth(20),
                      ),
                      child: DataView(productModel))
                ])),
            ExpandableTextWidget(text: productModel.description!)
          ],
        ),
      ),
    );
  }
}
