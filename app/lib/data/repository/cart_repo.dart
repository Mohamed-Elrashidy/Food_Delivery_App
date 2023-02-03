import 'dart:convert';

import 'package:app/controller/cart_controller.dart';
import 'package:app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});
  List<String> cart = [];
  List<String> cartHistory = [];
  void addToCartList(List<CartModel> cartList) {
    var time = DateTime.now().toString();

    List<String> cart = [];
    cartList.forEach((element) {
      print(element.time.toString() + "this the first time ");
      print(time + "this is the new time");
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });

    return cartList;
  }

  void addToCartHistory() {
    cart = [];
    cartHistory = [];
    getCartList().forEach((element) {
      cart.add(jsonEncode(element));
    });
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }

    removeCart();

    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);

    getCartHistoryList();
  }

  void removeCart() {
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  List<CartModel> getCartHistoryList() {
    cartHistory = [];
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) {
      return cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    print("hsitory is length ${cartListHistory.length}");

    for (int i = 0; i < cartListHistory.length; i++) {
      print(cartListHistory[i].toJson());
      print("time for this order is ${cartListHistory[i].time}");
    }
    return cartListHistory;
  }

  Map<String,List<CartModel>> getCheckOutHistory(){
    Map<String,List<CartModel>> history={};
   List<CartModel> cartHistory=getCartHistoryList();
    for(int i=0;i<cartHistory.length;i++)
  {
    if(history.containsKey(cartHistory[i].time))
  {
    history[cartHistory[i].time]!.add(cartHistory[i]);
  }
    else
  {
    List<CartModel>curr=[];
    curr.add(cartHistory[i]);

    history.putIfAbsent(cartHistory[i].time!, () => curr);
  }
  }

    return history;
}
}
