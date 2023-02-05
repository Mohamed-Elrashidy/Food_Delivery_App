import 'package:app/model/cart_model.dart';
import 'package:app/model/product.dart';
import 'package:get/get.dart';
import '../data/repository/cart_repo.dart';

class CartController extends GetxController {

  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};
  // only for storage and shared prerefrence
  List<CartModel> storageItems=[];

  void addItem(ProductModel productModel, int quantity) {
    print('here');

    if (_items.containsKey(productModel.id!)) {
      _items.forEach((key, value) {
        print('id is ' +
            value.id.toString() +
            'qyatutt us ' +
            value.quantity.toString());
      });
      print('modify');
      _items.update(productModel.id!, (value) {
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
      _items[productModel.id!] = CartModel(
          id: productModel.id,
          name: productModel.name,
          price: productModel.price,
          img: productModel.img,
          quantity: quantity,
          isExit: true,
          time: DateTime.now().toString());
    }
    if (_items[productModel.id]!.quantity! <= 0) {
      print("we are wait here///************************");
      _items.remove(productModel.id);
    }
    cartRepo.addToCartList(listOfCartItems);
    update();
  }

  bool existInCart(ProductModel product) {
    print("cart items contain  ... itmes " + _items.length.toString());
    print(_items);
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    int quantity = 0;
    if (existInCart(product)) {
      quantity = _items[product.id]!.quantity!;
    }

    return quantity;
  }

  int get totalItems{
    int total=0;
    _items.forEach((key, value) {
      total+=value.quantity!;
    });
    return total;
  }

  List<CartModel> get listOfCartItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  void addToCart(int id)
  {
    _items.update(id, (value) => CartModel(
        id: _items[id]!.id,
        name: _items[id]!.name,
        price: _items[id]!.price,
        img: _items[id]!.img,
        quantity: _items[id]!.quantity!+1,
        isExit: true,
        time: DateTime.now().toString()));
    cartRepo.addToCartList(listOfCartItems);

    update();
  }
  void removeFromCart(int id)
  {
    _items.update(id, (value) => CartModel(
        id: _items[id]!.id,
        name: _items[id]!.name,
        price: _items[id]!.price,
        img: _items[id]!.img,
        quantity: _items[id]!.quantity!-1,
        isExit: true,
        time: DateTime.now().toString()));
    if(_items[id]!.quantity==0)
      _items.remove(id);
    cartRepo.addToCartList(listOfCartItems);
    update();
  }
  int totalCost()
  {
    int total=0;
    _items.forEach((key, value) {
      total+=value.quantity!*value.price!;
    });
    return total as int;
  }
  void clearItems()
  {//print('reached');
    _items={};
    update();
  }
  List <CartModel> getCartData (){
    setCart=cartRepo.getCartList();

  return storageItems;
}

set setCart(List<CartModel> items)
{
   storageItems=items;
   print("items size in begining is " +items.length.toString());
   for(int i=0;i<storageItems.length;i++)
     {
       _items.putIfAbsent(storageItems[i].id!, () => storageItems[i]);
     }
}
void addtoHistory(){
    cartRepo.addToCartHistory();
    clearItems();
}
Map<String,List<CartModel>> getHistoryOfOperations()
{
  var curr=cartRepo.getCheckOutHistory();
  print(curr);
  return curr;
}
set setItems(Map<int,CartModel> setItems){
    _items={};
    _items=setItems;
}
 void addToCartList()
 {
   cartRepo.addToCartList(listOfCartItems);
   update();
 }
}
