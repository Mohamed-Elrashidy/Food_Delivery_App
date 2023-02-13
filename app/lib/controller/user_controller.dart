import 'dart:convert';

import 'package:app/data/repository/user_repo.dart';
import 'package:app/model/user_model.dart';
import 'package:get/get.dart';

import '../model/response_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userMOdel => _userModel;
  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    update();
    Response response = await userRepo.getUserInfo();

    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      userRepo.saveUserData(jsonEncode(_userModel.toJson()));
      responseModel = ResponseModel(true, "SUCCESSFULLY");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  initUserData() {
    String data = userRepo.initUserData();
    if (data != '') {


      _userModel = UserModel.fromJson(jsonDecode(data));
    }
    update();
  }
}
