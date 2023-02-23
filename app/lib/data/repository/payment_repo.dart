import 'package:app/base/snack_bar_message.dart';
import 'package:app/data/api/payment_client.dart';
import 'package:app/utils/app_constants.dart';

class PaymentRepo{
  PaymentClient paymentClient;
  PaymentRepo({required this.paymentClient});
  Future<void> postAuth(String uri)async
  {
    try{await paymentClient.postData(uri, {
      "api_key":AppConstants.PAYMOB_API_KEY
    }).then((value) {
      if(value.isOk)
      AppConstants.PAYMENT_FIRST_TOKEN=value.body["token"];
    });}
    catch(e)
    {
      showSnackBar("Payment Authentication failed!!");
    }
  }
  Future<void> postOrder(String uri,{
    required String firstName,
    required String secondName,
    required String email,
    required String phone,
    required String price,
  })async
  {
   try{await paymentClient.postData(AppConstants.PAYMOB_ORDER_URI, {
     "auth_token":AppConstants.PAYMENT_FIRST_TOKEN,
     "amount_cents":price,

   }).then((value) {
     AppConstants.PAYMENT_ORDER_ID=value.body['id'];
     getPaymentRequestId(uri, firstName: firstName, secondName: secondName, email: email, phone: phone, price: price);
   });}
       catch(e)
    {
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
 "amount_cents": price,
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
 "last_name": secondName,
 "state": "NA"
 },
 "currency": "EGP",
 "integration_id": AppConstants.INTEGREATION_ID_CARD,
 "lock_order_when_paid": "false"
 }
  ).then((value) {
    AppConstants.PAYMENT_LAST_TOKEN=value.body['token'];
  });}
      catch(e)
   {
     showSnackBar("Get Payment Id failed");
   }
 }

}