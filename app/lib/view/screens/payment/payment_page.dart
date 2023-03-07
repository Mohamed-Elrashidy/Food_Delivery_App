import 'package:app/controller/cart_controller.dart';
import 'package:app/controller/payment_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/user_model.dart';

class PaymobVisaScreen extends StatefulWidget {
  @override
  _PaymobVisaScreenState createState() => _PaymobVisaScreenState();
}

class _PaymobVisaScreenState extends State<PaymobVisaScreen> {
  late WebViewController _controller;
  @override


  @override
  Widget build(BuildContext context) {
    print("last token is : "+AppConstants.PAYMENT_LAST_TOKEN);
    return Scaffold(
      appBar: AppBar(
        title: Text('Paymob Visa'),
      ),
      body: WebView(
        initialUrl: AppConstants.VISAVIEW,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;

        },


      ),
    );
  }
}
