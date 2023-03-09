import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/screens/order_pages/order_view.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/sign_in_start_widget.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({Key? key}) : super(key: key);

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage>
    with SingleTickerProviderStateMixin {
  late bool loggedIn;
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loggedIn = Get.find<AuthController>().userLoggedIn();
    print("this is the test : " + loggedIn.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          bottom: (loggedIn)
              ? TabBar(controller: _tabController, tabs: [
                  BigText(text: "running", color: Colors.white),
                  BigText(text: "history", color: Colors.white)
                ])
              : TabBar(
                  tabs: [],
                ),
          title: BigText(
            text: "My Orders",
            color: Colors.white,
          ),
          leading: Container(),
          centerTitle: true,
        ),
        body: (!loggedIn)
            ? SignInStartWidget()
            : TabBarView(
            controller: _tabController,
            children: [
                OrderView(running: true),
                OrderView(running: false)
              ]));
  }
}
