import 'package:get/get.dart';

import '../../utils/app_constants.dart';

class PaymentClient extends GetConnect implements GetxService{

PaymentClient()
{
  baseUrl=AppConstants.PAYMOB_BASE_URI;
  timeout=Duration(seconds: 60);
}

Future<Response> postData(String uri,Map<String,dynamic>data)async
{
  return await  post(uri, data);
}



}