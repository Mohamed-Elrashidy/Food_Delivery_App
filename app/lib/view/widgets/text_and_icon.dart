import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensionScale.dart';

class TextAndIconWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const TextAndIconWidget({required this.color,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon,color: color,size:Dimension.scaleWidth(20.0)),
      SizedBox(width: Dimension.scaleWidth(2.0),),
      SmallText(text: text)


    ],);
  }
}
