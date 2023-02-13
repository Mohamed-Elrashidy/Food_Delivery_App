import 'package:app/data/api/api_client.dart';
import 'package:app/model/sign_up_body.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.apiClient, required this.sharedPreferences});
  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstants.Registration_URI, signUpBody.toJson());
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"email": email, "password": password});
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstants.Token) ?? "none";
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
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
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
}
