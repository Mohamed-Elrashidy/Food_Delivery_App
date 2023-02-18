import 'package:app/controller/auth_controller.dart';
import 'package:app/controller/location_controller.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/model/address_model.dart';
import 'package:app/utils/colors.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/TextFieldBuilder.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/route_helper.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();
  late bool isLooged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(45.51563, 122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    beginner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Address Page",
          color: Colors.white,
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {

          if (userController.userMOdel != null &&
              _contactPersonName.text=="") {
            print("Entered");
            _contactPersonName.text = userController.userMOdel.name;
            _contactPersonNumber.text = userController.userMOdel.phone;
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              print(Get.find<LocationController>().addressList[0].address);

              _addressController.text =
                  Get.find<LocationController>().addressList[0].address;

            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {

            return SingleChildScrollView(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                        height: Dimension.scaleHeight(100),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2, color: AppColors.mainColor)),
                        child: Stack(
                          children: [
                            GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: _initialPosition,
                                zoom: 17,
                              ),
                              zoomControlsEnabled: false,
                              compassEnabled: false,
                              indoorViewEnabled: true,
                              mapToolbarEnabled: false,
                              myLocationEnabled: true,
                              onCameraIdle: () {
                                locationController.updatePosition(
                                    _cameraPosition, true);
                              },
                              onCameraMove: ((position) =>
                                  _cameraPosition = position),
                              onMapCreated: (GoogleMapController controller) {
                                locationController.setMapController(controller);
                              },
                            )
                          ],
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Dimension.scaleWidth(10)),
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: locationController.addressTypeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  width: Dimension.scaleWidth(70),
                                  margin: EdgeInsets.only(
                                      right: Dimension.scaleWidth(10)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimension.scaleHeight(5)),
                                      color: Theme.of(context).cardColor!,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200]!,
                                            spreadRadius: 1,
                                            blurRadius: 5)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        (index == 0)
                                            ? (Icons.home)
                                            : (index == 1)
                                                ? Icons.work
                                                : Icons.location_on_rounded,
                                        color: locationController
                                                    .addressTypeIndex ==
                                                index
                                            ? AppColors.mainColor
                                            : Theme.of(context).disabledColor,
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                    SizedBox(
                      height: Dimension.scaleHeight(20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.scaleWidth(20)),
                      child: BigText(text: "Delivery Address"),
                    ),
                    SizedBox(
                      height: Dimension.scaleHeight(10),
                    ),
                    TextFieldBuilder(
                        controller: _addressController,
                        prefixIcon: Icons.map,
                        hintText: "Your address"),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.scaleWidth(20)),
                      child: BigText(text: "Contact name"),
                    ),
                    TextFieldBuilder(
                        controller: _contactPersonName,
                        prefixIcon: Icons.person,
                        hintText: "Your name"),
                    Padding(
                      padding: EdgeInsets.only(left: Dimension.scaleWidth(20)),
                      child: BigText(text: "Contact number"),
                    ),
                    TextFieldBuilder(
                        controller: _contactPersonNumber,
                        prefixIcon: Icons.phone,
                        hintText: "Your number"),
                  ],
                ),
              ),
            );
          });
        },
      ),
      bottomNavigationBar: bottomNavigationBarBuilder(),
    );
  }

  Widget bottomNavigationBarBuilder() {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Container(
        height: Dimension.scaleHeight(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimension.scaleHeight(10)),
              topRight: Radius.circular(Dimension.scaleHeight(10))),
          color: Colors.grey[100],
        ),
        padding: EdgeInsets.symmetric(
            vertical: Dimension.scaleHeight(10),
            horizontal: Dimension.scaleWidth(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                AddressModel _addressModel = AddressModel(
                    addressType: locationController
                        .addressTypeList[locationController.addressTypeIndex],
                    contactPersonName: _contactPersonName.text,
                    contactPersonNumber: _contactPersonNumber.text,
                    address: _addressController.text,
                    latitude: locationController.position.latitude.toString(),
                    longitude:
                        locationController.position.longitude.toString());
                locationController.addAddress(_addressModel);
                locationController
                    .getAddressList(Get.find<UserController>().userMOdel.email);
                print(locationController.addressList);
                Get.offNamed(RouteHelper.intial);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimension.scaleWidth(20),
                    vertical: Dimension.scaleHeight(10)),
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.circular(Dimension.scaleWidth(16))),
                child: BigText(
                  text: "save address",
                  color: Colors.white,
                  size: 26,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
  beginner()
   {
    isLooged = Get.find<AuthController>().userLoggedIn();

    if (Get.find<AuthController>().userLoggedIn() &&
        Get.find<UserController>().userMOdel == null) {
      {
        Get.find<UserController>().getUserInfo();
      }
    }
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<LocationController>()
          .getAddressList(Get.find<UserController>().userMOdel.email);
    }
    Get.find<LocationController>().getAddressList(Get.find<UserController>().userMOdel.email);
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _addressController.text=Get.find<LocationController>().addressList[0].address;
      print("this is our test"+_addressController.text);
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
    print("answer is "+Get.find<LocationController>().addressList.toString());

  }
}
