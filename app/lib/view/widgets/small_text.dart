import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final double height;
 // final TextOverflow overflow;

  const SmallText(
      {required this.text,
        this.color = const Color(0xFFccc7c5),
        this.size = 14,
        this.height=1.2
        });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(


        color: color,
        fontSize: size,
        height: height
      ),
maxLines: 10,
      ),
    );
  }
}
