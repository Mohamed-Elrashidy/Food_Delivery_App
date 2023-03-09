import 'dart:convert';

import 'package:app/data/repository/order_repo.dart';
import 'package:get/get.dart';

import '../model/order_model.dart';

class OrderController extends GetxController {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  List<OrderModel> historyOrderList=[];
  List<OrderModel> currnetOrderList=[];
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