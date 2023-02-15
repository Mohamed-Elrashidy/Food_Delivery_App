import 'dart:convert';

import 'package:app/data/repository/auth_repo.dart';
import 'package:app/model/response_model.dart';
import 'package:app/model/sign_up_body.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<String> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    String response = await authRepo.registration(signUpBody);
    //late ResponseModel responseModel;
    if (response != "") {
      authRepo.saveUserToken(response);}
    //  responseModel = ResponseModel(true, response);
    // } else {
    //   responseModel = ResponseModel(false, response.statusText!);
    // }
    _isLoading = false;
    update();
    return response;
   // return responseModel;
  }

  Future<String> login(String email, String password) async {
    _isLoading = true;
    update();
    String response = await authRepo.login(email, password);

    if (response != "") {
      authRepo.saveUserToken(response);
     // responseModel = ResponseModel(true, response.body["token"]);
    } else {
     // responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return response;
  }
  getUserData(String email)
  {
    authRepo.getUserData(AppConstants.FIREBASE_USER_DATA, email);
  }
  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoogedIn();
  }
  bool clearSharedData()
  {
    return authRepo.clearSharedData();
  }
}
