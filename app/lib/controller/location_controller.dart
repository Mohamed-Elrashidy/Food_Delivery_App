import 'dart:convert';

import 'package:app/data/repository/location_repo.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/address_model.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _postion;
  late Position _pickPosition;

  bool get loading => _loading;
  Position get position => _postion;
  Position get pickPosition => _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark=>_placemark;
  Placemark get pickPlacemark=>_pickPlacemark;
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList=>_addressTypeList;

  int _addressTypeIndex = 0;
 int get addressTypeIndex=>_addressTypeIndex;
  List<AddressModel> get addressList => _addressList;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  late GoogleMapController _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController) {
    _mapController = GoogleMapController;
  }

  void updatePosition(CameraPosition cameraPosition, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _postion = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            speedAccuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude,
            timestamp: DateTime.now(),
            accuracy: 1,
            speedAccuracy: 1,
            altitude: 1,
            heading: 1,
            speed: 1,
          );
        }
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(LatLng(
              cameraPosition.target.latitude, cameraPosition.target.longitude));
          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);

        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    print("we are here ");
    String _address = "unknown Location found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    print("response is " + response.statusCode.toString());
    if (response.body["status"] == 'ok') {
      _address = response.body["results"][0]['formatted_address'].toString();
      print('printing address  ' + _address);
    } else {
      print("Error getting the google api");
    }
    return _address;
  }
  AddressModel getUserAddress()
  {
    late AddressModel _addressModel;
    _getAddress=jsonDecode(locationRepo.getUserAddress());
    try{

      _addressModel=AddressModel.fromJson(_getAddress);
    }
    catch(e)
    {
      print(e);
    }
    return _addressModel;
  }
  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }
}
