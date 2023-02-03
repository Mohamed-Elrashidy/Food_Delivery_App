import 'dart:math';

import 'package:app/controller/cart_controller.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../model/cart_model.dart';
import '../../../utils/app_constants.dart';
import '../../widgets/app_icon.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [AppBarBuilder(), ListViewBuilder()],
      ),
    );
  }

  Widget AppBarBuilder() {
    return Container(
      color: AppColors.mainColor,
      width: double.maxFinite,
      padding: EdgeInsets.only(top: Dimension.scaleHeight(45), bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BigText(text: "Cart History", color: Colors.white),
          AppIcon(
            icon: Icons.shopping_cart_outlined,
            color: Colors.yellow,
            iconColor: AppColors.mainColor,
          )
        ],
      ),
    );
  }

  Widget ListViewBuilder() {
    CartController cartController = Get.find<CartController>();
    Map<String, List<CartModel>> cartHistory =
        cartController.getHistoryOfOperations();
    print("we are here");
    print(cartHistory);
    List<String> keys = [];
    cartHistory.forEach((key, value) {
      keys.add(key);
    });
    return Container(
        height: Dimension.screenHeight - Dimension.scaleHeight(200),
        margin: EdgeInsets.only(
          top: Dimension.scaleHeight(20),
          left: Dimension.scaleWidth(20),
          right: Dimension.scaleWidth(20),
        ),
        child: ListView.builder(
            itemCount: cartHistory.length,
            itemBuilder: (_, index) {
              return itemView(cartHistory[keys[index]]!);
            }));
  }

  Widget itemView(List<CartModel> items) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimension.scaleHeight(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IEF  immediatly involved function
          ((){
          var date= DateFormat("yyyy-MM-dd HH:mm:ss").parse(items[0].time!);
           var outputFormat= DateFormat("MM/dd/yyyy hh:mm a");
           var outputDate = outputFormat.format(date);
            return BigText(text: outputDate);
          }()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(min(3, items.length), (index) {
                    return Container(
                      decoration: BoxDecoration(),
                      padding: EdgeInsets.all(Dimension.scaleWidth(3)),
                      width: Dimension.scaleWidth(85),
                      height: Dimension.scaleWidth(85),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(Dimension.scaleWidth(10)),
                        child: Image.network(
                            AppConstants.BASE_URI +
                                AppConstants.UPLOAD_URL +
                                items[index].img!,
                            fit: BoxFit.cover),
                      ),
                    );
                  })),
              Container(
                height: Dimension.scaleWidth(110),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SmallText(text: "Total",color: Colors.black87,),
                    BigText(
                      text: items.length.toString() + " Items",
                      color: AppColors.titleColor,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimension.scaleWidth(5)

                        ),
                        border: Border.all(color: AppColors.mainColor,width: 1),

                      ),
                      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 3),
                      child: SmallText(text:"view more",size: 12,),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
