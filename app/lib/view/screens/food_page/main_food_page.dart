import 'package:app/view/screens/food_page/app_bar_widget.dart';
import 'package:flutter/material.dart';

import '../../../utils/dimensionScale.dart';
import 'food_page_page_view.dart';
import 'food_page_popular.dart';

class MainFoodpage extends StatefulWidget {
  const MainFoodpage({Key? key}) : super(key: key);

  @override
  State<MainFoodpage> createState() => _MainFoodpageState();
}

class _MainFoodpageState extends State<MainFoodpage> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return Scaffold(body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarWidget(),
            FoodPageViewWidget(),
            SizedBox(height: Dimension.scaleHeight(15),),
            Container(child: FoodPagePopular()),

          ],
        ),
      ),
    ),);
  }
}
