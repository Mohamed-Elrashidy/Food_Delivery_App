import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final TextOverflow overflow;

  const BigText(
      {required this.text,
      this.color = const Color(0xFF332d2b),
      this.size = 20,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text,style: TextStyle(

        color: color,
        fontSize: size,
        overflow: overflow,

      ),
      maxLines: 1,
      ),
    );
  }
}
