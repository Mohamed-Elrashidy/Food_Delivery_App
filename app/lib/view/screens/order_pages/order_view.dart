import 'package:app/controller/order_controller.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/order_model.dart';

class OrderView extends StatelessWidget {
  bool running;
  OrderView({required this.running});
  late List<OrderModel> orderList;
  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>().getOrders();
    if (running) {
      orderList = Get.find<OrderController>().currnetOrderList;
    } else
      orderList = Get.find<OrderController>().historyOrderList;

    return Scaffold(body: GetBuilder<OrderController>(
      builder: (controller) {
        return Container(
          height: Dimension.scaleHeight(500),
          child: ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                OrderModel currentOrder =
                    orderList[orderList.length - 1 - index];
                print("this is the id " + currentOrder.id.toString());
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      height: Dimension.scaleHeight(70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmallText(
                            text: "order_id:  #${currentOrder.id.toString()}",
                            color: Colors.black,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(5)),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                child: SmallText(
                                  text: currentOrder.orderStatus ?? "Pending",
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:Border.all(color:AppColors.mainColor)
                                    ,
                                    borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 6),
                                child: Row(
                                  children: [
                                    Image.asset("assets/image/tracking.png",scale: 2,color: AppColors.mainColor,),
                                    SizedBox(width: 2,),
                                    SmallText(
                                      text: "track order",
                                      color: AppColors.mainColor,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:Dimension.scaleWidth(100),right: Dimension.scaleWidth(20)),
                      height: 1,
                    color: Colors.grey[400],)
                  ],
                );
              }),
        );
      },
    ));
  }
}
