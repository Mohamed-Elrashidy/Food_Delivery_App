import 'package:flutter/material.dart';

import '../../utils/dimensionScale.dart';

class TextFieldBuilder extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final String hintText;
  late int maxline;
  bool isObsecure;
  bool currObsecure = true;
  TextFieldBuilder(
      {super.key,
      this.maxline=1,
        required this.controller,
      required this.prefixIcon,
      required this.hintText,
      this.isObsecure = false

      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:Dimension.scaleWidth(20),vertical: Dimension.scaleHeight(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimension.scaleWidth(15)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(0.2),
                offset: Offset(1, 1))
          ]),
      child: TextField(
        maxLines: maxline,
        obscureText: isObsecure,
        controller: controller,
        decoration: InputDecoration(

          prefixIcon: Icon(
            prefixIcon,
            color: Colors.yellow,
          ),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(Dimension.scaleWidth(15))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(Dimension.scaleWidth(15))),
        ),
      ),
    );
  }
}
