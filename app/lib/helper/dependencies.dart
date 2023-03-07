import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/location_controller.dart';
import 'package:app/controller/payment_controller.dart';
import 'package:app/controller/popular_product_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/data/api/api_client.dart';
import 'package:app/data/api/firebase_client.dart';
import 'package:app/data/api/payment_client.dart';
import 'package:app/data/repository/auth_repo.dart';
import 'package:app/data/repository/location_repo.dart';
import 'package:app/data/repository/popular_product_repo.dart';
import 'package:app/data/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/recommended_product_controller.dart';
import '../data/repository/cart_repo.dart';
import '../data/repository/payment_repo.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void>init()async{
  final sharedPreferences=await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreferences);

  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URI));
  Get.lazyPut(()=>FirebaseClient());




  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(),sharedPreferences: sharedPreferences));
   Get.lazyPut(() => LocationRepo(apiClient: Get.find(),firebaseClient: Get.find(),sharedPreferences: sharedPreferences));



  Get.lazyPut(()=>CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(),firebaseClient: Get.find(), sharedPreferences: sharedPreferences));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductrepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));


}