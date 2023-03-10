import 'dart:async';

import 'package:app/base/no_data_page.dart';
import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/location_controller.dart';
import 'package:app/controller/popular_product_controller.dart';
import 'package:app/controller/recommended_product_controller.dart';
import 'package:app/model/cart_model.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/TextFieldBuilder.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/order_controller.dart';
import '../../../controller/payment_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../data/api/payment_client.dart';
import '../../../data/repository/order_repo.dart';
import '../../../data/repository/payment_repo.dart';
import '../../../model/order_model.dart';
import '../../../model/user_model.dart';
import '../../../routes/route_helper.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bit_text.dart';
import '../../widgets/payment_method.dart';
import '../payment/payment_page.dart';

class CartPage extends StatelessWidget {
  TextEditingController _textController = TextEditingController();

  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      Get.find<OrderRepo>();
    } catch (e) {
      Get.lazyPut(() => OrderRepo(firebaseClient: Get.find()));
    }
    try {
      Get.find<OrderController>();
    } catch (e) {
      Get.lazyPut(() => OrderController(orderRepo: Get.find()));
    }

    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: bottomNavigationBarBuilder(context),
      body: Column(
        children: [
          AppBarWidget(),
          Container(
              height: Dimension.scaleHeight(
                  Dimension.screenHeight - Dimension.scaleHeight(380)),
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

  Widget bottomNavigationBarBuilder(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (controller) => Container(
              height: Dimension.scaleHeight(170),
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
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            showModalBottomSheetBuilder(context);
                          },
                          child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: Dimension.scaleHeight(20),
                                  horizontal: Dimension.scaleWidth(15)),
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimension.scaleHeight(20))),
                              child: Center(
                                  child: BigText(
                                text: "Payment Options",
                                color: Colors.white,
                              ))),
                        ),
                        SizedBox(height: 10),
                        Row(
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
                              onTap: () async {
                                if (Get.find<AuthController>().userLoggedIn()&&Get.find<OrderController>().paymentMethod=="Online Payment") {
                                  if (Get.find<LocationController>()
                                      .addressList
                                      .isEmpty)
                                    Get.toNamed(RouteHelper.addressRoute);
                                  else {
                                    Get.to(() => PaymobVisaScreen());

                                    // Get.offNamed(RouteHelper.intial);
                                  }
                                } else if(Get.find<AuthController>().userLoggedIn())
                                  {
                                    Get.find<CartController>().addtoHistory();

                                    OrderModel order = OrderModel(
                                        id: 100,
                                        userId: Get.find<UserController>().userMOdel.id ?? 10,
                                        orderPayment: Get.find<OrderController>().paymentMethod,
                                        orderNote: _textController.text

                                    );
                                    Get.find<OrderController>().addOrder(order);
                                  }
                                else {
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
                                  child: BigText(
                                    text: "Check Out",
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(height: Dimension.scaleHeight(85)),
            ));
  }

  Future showModalBottomSheetBuilder(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (_) {
          return Container(
            height: Dimension.scaleHeight(400),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.scaleHeight(50))),
            child: SingleChildScrollView(child: GetBuilder<OrderController>(
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PaymentMethod(Icons.money, "Cash Payment",
                        Icons.check_circle, "you pay after getting delivery"),
                    PaymentMethod(Icons.paypal_outlined, "Online Payment",
                        Icons.check_circle, "safest and fastest way to pay"),
                    SizedBox(
                      height: Dimension.scaleHeight(15),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: BigText(text: "Delivery Options")),
                    Row(
                      children: [
                        Radio(
                            value: controller.deliveryMethod,
                            groupValue: "Home Delivery",
                            onChanged: (value) {
                              controller.changeDeliveryMehtod("Home Delivery");
                            }),
                        BigText(text: "Home Delivery (\$1.2)")
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                            value: controller.deliveryMethod,
                            groupValue: "Take away",
                            onChanged: (value) {
                              controller.changeDeliveryMehtod("Take away");
                            }),
                        BigText(text: "Take away (Free)")
                      ],
                    ),
                    SizedBox(
                      height: Dimension.scaleHeight(20),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: BigText(text: "Additional info")),
                    TextFieldBuilder(
                      controller: _textController,
                      prefixIcon: Icons.info_outline,
                      hintText: "Additional info",
                      maxline: 3,
                    )
                  ],
                );
              },
            )),
          );
        },
        context: context);
  }
}
