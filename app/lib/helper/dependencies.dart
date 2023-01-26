import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/popular_product_controller.dart';
import 'package:app/data/api/api_client.dart';
import 'package:app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import '../controller/recommended_product_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void>init()async{
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URI));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
Get.lazyPut(()=>CartRepo());
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductrepo: Get.find()));
Get.lazyPut(() => CartController(cartRepo: CartRepo()));


}