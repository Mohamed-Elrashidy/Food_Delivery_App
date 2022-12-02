import 'package:app/controller/popular_product_controller.dart';
import 'package:app/data/api/api_client.dart';
import 'package:app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/app_constants.dart';

Future<void>init()async{
  Get.lazyPut(()=>ApiClient(appBaseUrl: AppConstants.BASE_URI));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
}