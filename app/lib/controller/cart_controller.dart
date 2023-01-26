import 'package:app/controller/recommended_product_controller.dart';
import 'package:app/model/cart_model.dart';
import 'package:app/model/product.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';

class CartController extends GetxController {

  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> items = {};

  void addItem(ProductModel productModel, int quantity) {
    print('here');

    if (items.containsKey(productModel.id!)) {
      items.forEach((key, value) {
        print('id is ' +
            value.id.toString() +
            'qyatutt us ' +
            value.quantity.toString());
      });
      print('modify');
      items.update(productModel.id!, (value) {
        return CartModel(
            id: value.id,
            name: value.name,
            price: value.price,
            img: value.img,
            quantity: value.quantity! + quantity,
            isExit: value.isExit,
            time: value.time);
      });
    } else {
      print('add');
      items[productModel.id!] = CartModel(
          id: productModel.id,
          name: productModel.name,
          price: productModel.price,
          img: productModel.img,
          quantity: quantity,
          isExit: true,
          time: DateTime.now().toString());
    }
    if (items[productModel.id]!.quantity! <= 0) {
      print("we are wait here///************************");
      items.remove(productModel.id);
    }
    update();
  }

  bool existInCart(ProductModel product) {
    print("cart items contain  ... itmes " + items.length.toString());
    print(items);
    if (items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (existInCart(product)) {
      quantity = items[product.id]!.quantity!;
    }

    return quantity;
  }

  int get totalItems{
    int total=0;
    items.forEach((key, value) {
      total+=value.quantity!;
    });
    return total;
  }
}
