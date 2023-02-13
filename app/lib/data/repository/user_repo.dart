import 'package:app/data/api/api_client.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo{
  SharedPreferences sharedPreferences;

  final ApiClient apiClient;
  UserRepo({required this.apiClient,required this.sharedPreferences});
 Future<Response> getUserInfo()async{
    return await apiClient.getData(AppConstants.USER_INFO_URI);
  }

  saveUserData(String data)
  {
    sharedPreferences.setString(AppConstants.USER_DATA, data);
  }

  String initUserData()
  {
    return sharedPreferences.getString(AppConstants.USER_DATA)??"";
  }
}