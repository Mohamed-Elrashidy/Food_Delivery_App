import 'package:app/view/screens/food_page/main_food_page.dart';
import 'package:app/view/screens/popular_food_detail/popular_food_detail.dart';
import 'package:app/view/screens/recommended_screen/recommended_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      //home:MainFoodpage()
      home: RecommendedPage()
    );
  }
}

