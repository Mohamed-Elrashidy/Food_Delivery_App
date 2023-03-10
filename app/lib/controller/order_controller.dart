import 'dart:convert';

import 'package:app/data/repository/order_repo.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';

class OrderController extends GetxController {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  List<OrderModel> historyOrderList=[];
  List<OrderModel> currnetOrderList=[];
  String _paymentMethod="Cash Payment";
  String get paymentMethod=>_paymentMethod;
  String _deliveryMethod ="Home Delivery";
  String get deliveryMethod=>_deliveryMethod;

    changeDeliveryMehtod(String method)
    {
      _deliveryMethod= method;
      update();
    }
    changePaymentMethod(String method)
    {
      _paymentMethod=method;
      update();
    }

  addOrder(OrderModel order)
  {
    orderRepo.addOrder(order.toJson());
  }

  getOrders()async
  {
    currnetOrderList=[];
    historyOrderList=[];
    List<dynamic> list= await orderRepo.getOrders();
    for(int i=0;i<list.length;i++)
      {

        OrderModel order=OrderModel.fromJson(list[i]);
        if(order.status.trim()=="Accepted")
          {
            currnetOrderList.add(order);
          }
        else {
          historyOrderList.add(order);
        }
      }
    print("this is running "+currnetOrderList.toString());
    print("this is the history " + historyOrderList.toString());
    update();

  }


}