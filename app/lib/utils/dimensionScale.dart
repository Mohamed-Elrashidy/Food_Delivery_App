import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Dimension{
//642

static final  double screenHeight=Get.context!.height;
static final double screenWidth=Get.context!.width;
 static double scaleHeight(double h)
{
  double y=650.0/h;
  return screenHeight/y;
}
static  double scaleWidth(double w)
  {
    double y=410.0/w;
    return screenWidth/y;
  }
}