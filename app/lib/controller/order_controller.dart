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
    List<dynamic> list= await orderRepo.getOrders();
    for(int i=0;i<list.length;i++)
      {
        OrderModel order=OrderModel.fromJson(list[i]);
        if(order.accepted!=null||order.confirmed!=null||order.handover!=null||order.pending!=null||order.pickedUp!=null||order.processing!=null)
          {
            currnetOrderList.add(order);
          }
        else
          historyOrderList.add(order);
      }
    update();

  }


}