import 'package:app/controller/user_controller.dart';
import 'package:app/data/api/firebase_client.dart';
import 'package:app/model/order_model.dart';
import 'package:app/utils/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class OrderRepo extends GetxService{
  FirebaseClient firebaseClient;
  OrderRepo({required this.firebaseClient});

  addOrder(Map<String,dynamic> data)
  {
    firebaseClient.addToCloud(AppConstants.ORDERS_ADDRRESS_URI+Get.find<UserController>().userMOdel.email, data);
  }

  Future<List<dynamic>>getOrders()async
  {
  return await  firebaseClient.getListFromCloud(AppConstants.ORDERS_ADDRRESS_URI+Get.find<UserController>().userMOdel.email);
  }


}