import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';

class TextAndIconWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  const TextAndIconWidget({required this.color,required this.text,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon,color: color,size:25),
      SizedBox(width: 10,),
      SmallText(text: text)


    ],);
  }
}
