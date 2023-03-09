import 'dart:core';

class AppConstants {
  static const String APP_NAME = "DBFodd";
  static const int APP_VERSION = 1;

  static const String BASE_URI = "http://mvs.bslmeiyu.com";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String Registration_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String USER_ADDRESS = "user_address";

  static const String Token = "DBToken";
  static const String PHONE = "DBPhone";
  static const String PASSWORD = "DBPassword";
  static const String UPLOAD_URL = '/uploads/';
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
  static const String USER_DATA = "user_data";

  // fire base paths

  static const String FIREBASE_USER_DATA = "/Users";
  static const String USER_ADDRESS_URI = "/Address/Q3edvqgsmPKnhDuM7PN6";
  static const String ORDERS_ADDRRESS_URI="/Orders/orders/";

  // payment uri

  static const String PAYMOB_BASE_URI = "https://accept.paymobsolutions.com/api";
  static const String PAYMOB_AUTH = "/auth/tokens";
  static const String PAYMOB_ORDER_URI = "/ecommerce/orders";
  static const String PAYMOB_GET_PAYMENT_ID_URI = "/acceptance/payment_keys";
  static String VISAVIEW =
      "https://accept.paymob.com/api/acceptance/iframes/735718?payment_token=";
// payment tokens
  static String PAYMENT_FIRST_TOKEN = "";
  static String PAYMENT_LAST_TOKEN = "";
  static String PAYMENT_ORDER_ID = "";
  static String PAYMENT_ID = "";
  static String REF_CODE = "";
  static const int INTEGREATION_ID_CARD = 3460672;

  static const String PAYMOB_API_KEY =
      "ZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6VXhNaUo5LmV5SndjbTltYVd4bFgzQnJJam8zTURVek1qa3NJbU5zWVhOeklqb2lUV1Z5WTJoaGJuUWlMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuMEpMbld6bmZ5dWI5akhYOHQtejd4Y09zbndaa3A4OGVQdFRNTGM2UHY3cGQxcVNZZWEwbC12QWtPQ1liMG5Gbm9ETlVMNWJkWG5IbjlaaTdBWThhQkE=";
}
