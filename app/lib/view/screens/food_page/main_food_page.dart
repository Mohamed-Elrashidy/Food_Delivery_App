import 'package:app/view/screens/food_page/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'food_page_page_view.dart';

class MainFoodpage extends StatefulWidget {
  const MainFoodpage({Key? key}) : super(key: key);

  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(),
            FoodPageViewWidget()
          ],
        ),
      ),
    ),);
  }
}
