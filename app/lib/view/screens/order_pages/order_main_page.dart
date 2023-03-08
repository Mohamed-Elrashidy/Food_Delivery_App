import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/sign_in_start_widget.dart';

class OrderMainPage extends StatefulWidget {
  const OrderMainPage({Key? key}) : super(key: key);

  @override
  State<OrderMainPage> createState() => _OrderMainPageState();
}

class _OrderMainPageState extends State<OrderMainPage> with SingleTickerProviderStateMixin  {
  late bool loggedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedIn=Get.find<AuthController>().userLoggedIn();
    print("this is the test : "+loggedIn.toString());
  }

  //TabController _tabController=TabController(length: 2, vsync:_ );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
           // controller: _tabController,
            tabs:[BigText(text: "Running",color:  Colors.black,),BigText(text: "History",color: Colors.white,)]),

        backgroundColor: AppColors.mainColor,
        title:BigText(text: "My Orders",color: Colors.white,),
            leading: Container(),
            centerTitle: true,
      ),
      body: (!loggedIn)?SignInStartWidget():Container()
    );
  }
}
