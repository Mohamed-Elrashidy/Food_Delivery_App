import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String message,{bool isError=true,String title="Error"})
{
  Get.snackbar(title, message,
  colorText:Colors.white,
  snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent
  );
}