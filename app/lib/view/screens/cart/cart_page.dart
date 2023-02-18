import 'package:app/base/no_data_page.dart';
import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/location_controller.dart';
import 'package:app/controller/popular_product_controller.dart';
import 'package:app/controller/recommended_product_controller.dart';
import 'package:app/model/cart_model.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/screens/food_page/main_food_page.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bit_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: bottomNavigationBarBuilder(),
      body: Column(
        children: [
          AppBarWidget(),
          Container(
              height: Dimension.scaleHeight(
                  Dimension.screenHeight - Dimension.scaleHeight(350)),
              child: GetBuilder<CartController>(
                builder: (controller) {
                  if (controller.listOfCartItems.length > 0)
                    return listWidget();
                  else
                    return NoDataPage(text: "your cart is empty");
                },
              ))
        ],
      ),
    ));
  }

  Widget AppBarWidget() {
    return Container(
      height: Dimension.scaleHeight(70),
      child: Container(
        padding: EdgeInsets.all(Dimension.scaleHeight(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIcon(
              icon: Icons.arrow_back_ios,
              ontap: () {
                Get.back();
              },
              color: AppColors.mainColor,
            ),
            SizedBox(
              width: Dimension.scaleWidth(50),
            ),
            AppIcon(
              icon: Icons.home,
              ontap: () {
                Get.toNamed(RouteHelper.intial);
              },
              color: AppColors.mainColor,
            ),
            AppIcon(
              icon: Icons.shopping_cart,
              color: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }

  Widget listWidget() {
    return GetBuilder<CartController>(builder: (cartController) {
      //recommedndedProduct.getRecommendedProductList();
      return Container(
        child: ListView.builder(
            //  physics: NeverScrollableScrollPhysics(),
            // shrinkWrap: true,
            itemCount: cartController.listOfCartItems.length,
            itemBuilder: (_, index) {
              return itemView(
                  cartController.listOfCartItems[index], cartController);
            }),
      );
    });
  }

  Widget itemView(CartModel cartModel, CartController cartController) {
    return InkWell(
        child: Container(
            height: Dimension.scaleHeight(130),
            padding: EdgeInsets.all(Dimension.scaleWidth(10)),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    int id = cartModel.id!;
                    int index = Get.find<RecommendedProductController>()
                        .recommendedProductList
                        .indexWhere((element) => id == element.id);
                    if (index >= 0) {
                      Get.toNamed(RouteHelper.recommendedFood, arguments: [
                        Get.find<PopularProductController>()
                            .popularProductList[index]
                      ]);
                    } else {
                      int index = Get.find<PopularProductController>()
                          .popularProductList
                          .indexWhere((element) => id == element.id);
                      Get.toNamed(RouteHelper.popularFood, arguments: [
                        Get.find<RecommendedProductController>()
                            .recommendedProductList[index]
                      ]);
                    }
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimension.scaleHeight(20)),
                    child: Image.network(
                      AppConstants.BASE_URI +
                          AppConstants.UPLOAD_URL +
                          cartModel.img!,
                      fit: BoxFit.cover,
                      width: Dimension.scaleWidth(130),
                      height: Dimension.scaleWidth(130),
                      cacheWidth: (Dimension.scaleWidth(130).ceil()),
                      cacheHeight: (Dimension.scaleWidth(130).ceil()),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimension.scaleWidth(10),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimension.scaleHeight(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: cartModel.name!),
                          const SmallText(text: "spicy"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "\$ ${cartModel.price}",
                                color: Colors.red,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimension.scaleWidth(24))),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            cartController
                                                .removeFromCart(cartModel.id!);
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
                                      BigText(
                                          text: cartModel.quantity.toString(),
                                          size: Dimension.scaleHeight(24)),
                                      SizedBox(
                                        width: Dimension.scaleWidth(8),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            cartController
                                                .addToCart(cartModel.id!);
                                          },
                                          child: Icon(Icons.add,
                                              color: Colors.black45,
                                              size: Dimension.scaleHeight(24)))
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimension.scaleHeight(10),
                                      horizontal: Dimension.scaleWidth(10))),
                            ],
                          )
                        ],
                      )),
                )
              ],
            )));
  }

  Widget bottomNavigationBarBuilder() {
    return GetBuilder<CartController>(
        builder: (controller) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.scaleHeight(10)),
                    topRight: Radius.circular(Dimension.scaleHeight(10))),
                color: Colors.grey[100],
              ),
              padding: EdgeInsets.symmetric(
                  vertical: Dimension.scaleHeight(10),
                  horizontal: Dimension.scaleWidth(10)),
              child: (controller.listOfCartItems.length > 0)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Dimension.scaleHeight(16))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Dimension.scaleWidth(5),
                                ),
                                BigText(
                                    text: '\$ ' +
                                        controller.totalCost().toString())
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: Dimension.scaleHeight(10),
                                horizontal: Dimension.scaleWidth(10))),
                        InkWell(
                          onTap: () {
                            if (Get.find<AuthController>().userLoggedIn()) {
                             if(Get.find<LocationController>().addressList.isEmpty)
                              Get.toNamed(RouteHelper.addressRoute);
                             else
                              {controller.addtoHistory();
                              Get.offNamed(RouteHelper.intial);
                              }
                            } else {
                              Get.toNamed(RouteHelper.singInPage);
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimension.scaleHeight(20),
                                  horizontal: Dimension.scaleWidth(15)),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimension.scaleHeight(20))),
                              child: BigText(text: "Check Out")),
                        )
                      ],
                    )
                  : Container(height: Dimension.scaleHeight(85)),
            ));
  }
}
