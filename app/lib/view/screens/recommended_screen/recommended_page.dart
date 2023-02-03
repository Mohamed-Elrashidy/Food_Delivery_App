import 'package:app/controller/popular_product_controller.dart';
import 'package:app/model/product.dart';
import 'package:app/view/widgets/app_bar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/recommended_product_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bit_text.dart';
import '../../widgets/data_view.dart';
import '../../widgets/expandable_text_widget.dart';

class RecommendedPage extends StatelessWidget {
  var data = Get.arguments;
  RecommendedPage({Key? key}) : super(key: key);
  ProductModel productModel = ProductModel();
  var recommendedProductController = Get.find<RecommendedProductController>();

  @override
  Widget build(BuildContext context) {
    productModel = data[0];
    recommendedProductController.init(productModel, Get.find());
    return Scaffold(
        bottomNavigationBar: bottomNavigationBarBuilder(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URI +
                      AppConstants.UPLOAD_URL +
                      productModel.img!,
                  fit: BoxFit.cover,
                ),
              ),
              expandedHeight: Dimension.scaleHeight(250),
              pinned: true,
              title: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [AppBarWidgets()],
                  )),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(

                    childCount: 1,
                    (BuildContext context, int index) => Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(16)),
                          height: Dimension.scaleHeight(400),
                          child: dataView(),
                        )))
          ],
        ));
  }

  Widget dataView() {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BigText(
                text: productModel.name!,
              ),
            ),
            ExpandableTextWidget(text: productModel.description!)
          ],
        ));
  }

  Widget bottomNavigationBarBuilder() {
    return GetBuilder<RecommendedProductController>(
      builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    controller.setQuantity(true);
                    print(controller.totatItems);
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
               GetBuilder<CartController>(builder:(_)=> BigText(
                 text: "\$${productModel.price}  X " +
                     (controller.quantity + controller.cartItem).toString(),
               )),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: CircleAvatar(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    backgroundColor: AppColors.mainColor,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                //  color:Color.fromARGB(16, 217, 217, 222),
                //  color:AppColors.textColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimension.scaleHeight(20)),
                    topRight: Radius.circular(Dimension.scaleHeight(20))),
                color: Colors.grey[200],
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
                              BorderRadius.circular(Dimension.scaleHeight(24))),
                      child: Container(
                        height: Dimension.scaleWidth(40),
                        width: Dimension.scaleWidth(40),
                        child: AppIcon(
                          icon: Icons.favorite,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimension.scaleHeight(20),
                          horizontal: Dimension.scaleWidth(20))),
                  InkWell(
                    onTap: () {
                      Get.find<CartController>()
                          .addItem(productModel, controller.quantity);
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
            ),
          ],
        );
      },
    );
  }
}
