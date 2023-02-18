import 'dart:convert';

import 'package:app/model/address_model.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../api/firebase_client.dart';

class LocationRepo {
  final FirebaseClient firebaseClient;
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.firebaseClient,required this.sharedPreferences});

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData("${AppConstants.GEOCODE_URI}"
        "?lat=${latLng.latitude}&lng=${latLng.longitude}");
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }
  addAddress(AddressModel data)
   {// email is the act as the key for list of address for this user as it is unique for each user
    String email=jsonDecode(sharedPreferences.getString(AppConstants.USER_DATA)!)["email"];
   firebaseClient.addToCloud(AppConstants.USER_ADDRESS_URI+'/'+email, data.toJson()) ;
  }


  Future<List<AddressModel>> getAddressList(String email)async
  {
    List<AddressModel> _addressList=[];


    await firebaseClient.getListFromCloud(AppConstants.USER_ADDRESS_URI+'/'+email).then((value) {
       value.forEach((element) {_addressList.add(AddressModel.fromJson(element));});

    });
    if(_addressList.length>0)
    {String userAddress= jsonEncode(_addressList[0]);
    sharedPreferences.setString(AppConstants.USER_ADDRESS,userAddress );}
    return _addressList;

  }

}
