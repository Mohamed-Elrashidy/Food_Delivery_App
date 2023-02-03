import 'package:app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../model/product.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  List<dynamic> get popularProductList => _popularProductList;
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {

      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      //print('We are here /////////////////////////////////');

    }
  }
}
