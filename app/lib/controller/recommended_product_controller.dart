import 'package:app/controller/cart_controller.dart';
import 'package:app/model/product.dart';
import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/colors.dart';
class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductrepo;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  var   _cart;
  List<dynamic> _recommendedProductList = [];
  int _quantity = 0;
  int _cartItem = 0;

  RecommendedProductController({required this.recommendedProductrepo});
  List<dynamic> get recommendedProductList => _recommendedProductList;
  int get cartItem => _cartItem;
  int get quantity => _quantity;

  Future<void> getRecommendedProductList() async {
    Response resoponse =
        await recommendedProductrepo.getRecommendedProductList();
    if (resoponse.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(resoponse.body).products);
      _isLoaded = true;
      // print('We are there/////////////////');
      // print('Loadedddddd');

      update();
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if (_quantity+_cartItem >= 20) {
        Get.snackbar("Full limit", "You can\'t add more than 20 items",
            backgroundColor: AppColors.mainColor);
      } else {
        // print("reached");
        _quantity++;
      }
    } else {
      if (_quantity + _cartItem == 0) {
        Get.snackbar("No items", "You have to select number greater than zero",
            backgroundColor: AppColors.mainColor);
      } else {
        _quantity--;
      }
    }
    update();
  }

  void setZero(CartController cart,ProductModel product) {
    _quantity = 0;
    _cartItem = 0;
    var exist = false;
    _cart = cart;
    exist = _cart.existInCart(product);
    if (exist) {
      _cartItem = cart.getQuantity(product);
    }
    update();
  }

  void init(ProductModel product, CartController cart) {
    _quantity = 0;
    _cartItem = 0;
    var exist = false;
    _cart = cart;
    exist = _cart.existInCart(product);
    if (exist) {
      _cartItem = cart.getQuantity(product);
    }
    // update();
    //print("quantity is " + _cartItem.toString());
  //  print("exist or not" + exist.toString());
  }
  int get totatItems{
    return _cart.totalItems;
  }
}
