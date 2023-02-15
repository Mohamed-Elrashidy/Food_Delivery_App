import 'package:app/base/snack_bar_message.dart';
import 'package:app/data/api/api_client.dart';
import 'package:app/data/api/firebase_client.dart';
import 'package:app/model/sign_up_body.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final FirebaseClient firebaseClient;
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo(
      {required this.apiClient,
      required this.firebaseClient,
      required this.sharedPreferences});
  Future<String> registration(SignUpBody signUpBody) async {
   return await firebaseClient.signUp(signUpBody.email, signUpBody.password, signUpBody.toJson());
    // return await apiClient.postData(
    //     AppConstants.Registration_URI, signUpBody.toJson());
  }

  Future<String> login(String email, String password) async {
     String response =await firebaseClient.signIn(email, password);

   return response;
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.Token) ?? "none";
  }

  Future<bool> saveUserToken(String token) async {
    //firebaseClient.token = token;
   // apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.Token, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {}
  }

  bool userLoogedIn() {
    return sharedPreferences.containsKey(AppConstants.Token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.Token);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.PHONE);
    return true;
  }
  Future<String> getUserData(String uri,String email)async
  {
    String data="";
  try {
     data = await firebaseClient.getFromCloud(uri, "email", email);

    sharedPreferences.setString(AppConstants.USER_DATA, data);
    print(data);
  }
  catch(e)
    {
     showSnackBar(e.toString());
    }
  return data;
  }
}
