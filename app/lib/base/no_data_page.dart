
import 'package:app/utils/dimensionScale.dart';
import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  const NoDataPage({ required this.text,
    this.imgPath="assets/image/empty_cart.png"});
  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imgPath,height: Dimension.screenHeight*0.22,
        width: Dimension.screenWidth*0.22,),
        SizedBox(height :10),
        Text(text,style:TextStyle(
          fontSize:Dimension.screenHeight*0.0175,
          color: Theme.of(context).disabledColor
        )
        ,textAlign: TextAlign.center,
        )
      ],
    );
  }
}
