import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token="";
  final String appBaseUrl;
  late Map<String,String>_mainHeaders;
  ApiClient({required this.appBaseUrl}){
    baseUrl=appBaseUrl;
    timeout=Duration(seconds:30);
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  Future<Response> getData(String uri ,{Map<String,String>?headers})async
  {
    try{
      Response response=await get(uri,
      headers:headers??_mainHeaders
      );
      return response;
    }
    catch(e)
    {
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

Future<Response>  postData(String uri,dynamic body)async
  {
    print(body);
    try{
      Response response = await post(uri,body,headers:_mainHeaders );
      print("response is "+response.statusCode.toString()!);
      print('response is '+ response.statusText.toString()!);
      return response;
    }catch(e)
    {
      print(e.toString());


      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  void updateHeader(String token)
  {
    _mainHeaders={
      'Content-type':'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
}