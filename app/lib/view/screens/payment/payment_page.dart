import 'dart:async';
import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/order_controller.dart';
import 'package:app/controller/payment_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../data/api/payment_client.dart';
import '../../../data/repository/order_repo.dart';
import '../../../data/repository/payment_repo.dart';
import '../../../model/order_model.dart';
import '../../../model/user_model.dart';
import '../../widgets/bit_text.dart';

class PaymobVisaScreen extends StatefulWidget {
  @override
  _PaymobVisaScreenState createState() => _PaymobVisaScreenState();
}

class _PaymobVisaScreenState extends State<PaymobVisaScreen> {
  late WebViewController _controller;
  bool flag=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserModel user = Get.find<UserController>().userMOdel;

    Get.lazyPut(()=>PaymentClient());
    Get.lazyPut(() => PaymentRepo(paymentClient: Get.find()));
    Get.lazyPut(() => PaymentController(paymentRepo:Get.find()));
     Get.find<PaymentController>().postOrder(AppConstants.PAYMOB_ORDER_URI,
        firstName: user.name.split(' ')[0],
        secondName: "",
        email: user.email,
        phone: user.phone,
        price: Get.find<CartController>().totalCost().toString());
     Timer(Duration(seconds: 2), () {}
      );
  }

  @override
  Widget build(BuildContext context) {
    print("last token is : "+AppConstants.PAYMENT_LAST_TOKEN);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
          Get.back();
        },

        ),
        title: Text('Paymob Visa'),
        centerTitle: true,
      ),
      body: Column(

          children: [
            SizedBox(height: Dimension.scaleHeight(50),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      flag=true;
                    });
                  },
                  child: Container(
          decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [ BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1, 1))]

          ),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: BigText(text:"Paymob",color: Colors.blue,),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimension.scaleHeight(50),),
            (flag)?
              Expanded(
                child: WebView(
                initialUrl: AppConstants.VISAVIEW,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;

                },

                 onPageFinished: (String s){
                   Get.lazyPut(() => OrderRepo(firebaseClient: Get.find()));
                   Get.lazyPut(() => OrderController(orderRepo:Get.find()));

                   Get.find<CartController>().addtoHistory();
                  OrderModel order = OrderModel(id: 1000, userId: Get.find<UserController>().userMOdel.id??10);
                   Get.find<OrderController>().addOrder(order);
                   print("finished **************************");
                   print("your url is : "+AppConstants.VISAVIEW);

                 },

            ),
              ):Container(),
          ],
        ),

    );
  }
}
