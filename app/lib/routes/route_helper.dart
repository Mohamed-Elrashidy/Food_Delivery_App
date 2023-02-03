import 'package:app/model/product.dart';
import 'package:app/view/screens/cart/cart_page.dart';
import 'package:app/view/screens/food_page/main_food_page.dart';
import 'package:app/view/screens/home_page/home_page.dart';
import 'package:app/view/screens/popular_food_detail/popular_food_detail.dart';
import 'package:app/view/screens/recommended_screen/recommended_page.dart';
import 'package:app/view/screens/splash/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RouteHelper {
  static const String intial = '/';
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String splashScreen ="/splash-screen";
  static List<GetPage> routes = [

    GetPage(name: "/", page: () => const HomePage()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),

    GetPage(
      name: popularFood,
      page: () => PopularFoodDetails(),
      transition: Transition.fade,
      arguments: [ProductModel()],
    ),
    GetPage(
      name: recommendedFood,
      page: () => RecommendedPage(),
      transition: Transition.fade,
      arguments: [ProductModel()],
    ),
    GetPage(
        name: cartPage,
        page: () => const CartPage(),
        transition: Transition.fade),
  ];
}
