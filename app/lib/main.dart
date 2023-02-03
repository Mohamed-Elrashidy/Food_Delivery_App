import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/popular_product_controller.dart';
import 'package:app/controller/recommended_product_controller.dart';
import 'package:app/data/repository/cart_repo.dart';
import 'package:app/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'helper/dependencies.dart' as dep;
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<CartRepo>().getCartHistoryList();
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    Get.find<CartController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      //home:SplashScreen(),
      // home: MainFoodpage(),
      getPages: RouteHelper.routes,
      initialRoute: RouteHelper.splashScreen,
    );
  }
}
