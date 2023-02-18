import 'dart:core';

class AppConstants {
  static const String APP_NAME = "DBFodd";
  static const int APP_VERSION = 1;

  static const String BASE_URI = "http://mvs.bslmeiyu.com";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String Registration_URI = "/api/v1/auth/register";
  static const String  LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI="/api/v1/customer/info";
  static const String GEOCODE_URI="/api/v1/config/geocode-api";
  static const String USER_ADDRESS="user_address";

  static const String Token = "DBToken";
  static const String PHONE = "DBPhone";
  static const String PASSWORD = "DBPassword";
  static const String UPLOAD_URL = '/uploads/';
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String USER_DATA ="user_data";

  // fire base paths

  static const String FIREBASE_USER_DATA="/Users";
  static const String USER_ADDRESS_URI="/Address/Q3edvqgsmPKnhDuM7PN6";
}
