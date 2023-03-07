import 'dart:convert';

import 'package:app/base/snack_bar_message.dart';
import 'package:app/data/api/payment_client.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class PaymentRepo{
  PaymentClient paymentClient;
  PaymentRepo({required this.paymentClient});

  // paymob auth and get the first token
  Future<void> postAuth(String uri)async
  {
    try{await paymentClient.postData(uri, {
      "api_key":AppConstants.PAYMOB_API_KEY
    }).then((value) {
      if(value.isOk)
      AppConstants.PAYMENT_FIRST_TOKEN=value.body["token"];
    });
    print("auth success");

    }
    catch(e)
    {
      showSnackBar("Payment Authentication failed!!");
    }
  }
  // send payment request and get id for the order
  Future<void> postOrder(String uri,{
    required String firstName,
    required String secondName,
    required String email,
    required String phone,
    required String price,
  })async
  {
    await postAuth(AppConstants.PAYMOB_AUTH);
   try{await paymentClient.postData(AppConstants.PAYMOB_ORDER_URI, {
     "auth_token":AppConstants.PAYMENT_FIRST_TOKEN,
     "amount_cents":price,
   }
    ).then((value) async {
     AppConstants.PAYMENT_ORDER_ID=value.body['id'].toString();
     showSnackBar(value.body['id'].toString());

     await getPaymentRequestId(uri, firstName: firstName, secondName: secondName, email: email, phone: phone, price: price);

   });
   print("payment order success");

   }
       catch(e)
    {
      print(e);
      showSnackBar(e.toString());
      showSnackBar("Payment order failed");
    }
}
 Future<void>getPaymentRequestId(uri,{
    required String firstName,
   required String secondName,
   required String email,
   required String phone,
   required String price,
})async
 {
  try{paymentClient.postData(uri,
 {
 "auth_token": AppConstants.PAYMENT_FIRST_TOKEN,
 "amount_cents": price*100,
 "expiration": 3600,
 "order_id": AppConstants.PAYMENT_ORDER_ID,
 "billing_data": {
 "apartment": "NA",
 "email": email,
 "floor": "NA",
 "first_name": firstName,
 "street": "NA",
 "building": "NA",
 "phone_number": phone,
 "shipping_method": "NA",
 "postal_code": "NA",
 "city": "NA",
 "country": "NA",
 "last_name": "ja",
 "state": "NA"
 },
 "currency": "EGP",
 "integration_id": AppConstants.INTEGREATION_ID_CARD,
 "lock_order_when_paid": "false"

 }
  ).then((value) {
showSnackBar(value.body['token'].toString());
    AppConstants.PAYMENT_LAST_TOKEN=value.body['token'];
  });
  print("id success");

  }
      catch(e)
   {
     showSnackBar("Get Payment Id failed");
   }
 }



}




