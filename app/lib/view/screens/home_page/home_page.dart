import 'package:app/utils/colors.dart';
import 'package:app/view/screens/cart/cart_history.dart';
import 'package:app/view/screens/food_page/main_food_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/user_controller.dart';
import '../account/account_page.dart';
import '../auth/signin_page.dart';
import '../auth/signup_page.dart';
import '../order_pages/order_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void onTapNav(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<UserController>().initUserData();
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MainFoodpage(),
      OrderMainPage(),
      CartHistory(),
      AccountPage()
    ];
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "history"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "me"),
        ],
      ),
    );
  }
}
