import 'package:app/controller/order_controller.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/dimensionScale.dart';
import 'bit_text.dart';

class PaymentMethod extends StatelessWidget {
  IconData suffix;
  IconData icon;
  String title;
  String subtitle;
  PaymentMethod(this.icon,this.title,this.suffix,this.subtitle);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder:(controller){
      return InkWell(
        onTap: (){
          controller.changePaymentMethod(title);
        },
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.circular(Dimension.scaleHeight(12)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.grey[200]!,
                )
              ]
          ),
          margin: EdgeInsets.symmetric(horizontal: Dimension.scaleWidth(20),vertical: Dimension.scaleHeight(5)),
          child: Row(children: [
            Icon(icon,size: Dimension.scaleHeight(30),),
            SizedBox(width: Dimension.scaleWidth(20),),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [BigText(text: title),    SmallText(text: subtitle,)],
            )
            ,
            Spacer(),
            (title==controller.paymentMethod)?
            Icon(suffix,size:Dimension.scaleHeight(20),color: AppColors.mainColor,):Container()



          ],),
        ),
      );
    });
  }
}
