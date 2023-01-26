import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/dimensionScale.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({required this.text});

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool hiddenText = false;
  String firstText = "";
  String secondText = "";

  int textHeight = (Dimension.screenHeight / 5.64).floor();
  @override
  void initState() {

    super.initState();
    int tot=widget.text.length;
    if (widget.text.length > textHeight) {
      hiddenText = true;
      print(widget.text);
      print("//////////////////////////////////////////////////");
      firstText = widget.text.substring(0, textHeight);
      print(firstText);
      print('//////////////////////');
      print(widget.text);

      secondText = widget.text.substring(textHeight + 1, widget.text.length);
    print(secondText);
    print('//////////////////////');
    } else {
      firstText = widget.text;
      secondText = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:Dimension.scaleHeight(150),
      padding: EdgeInsets.symmetric(vertical: Dimension.scaleHeight(10)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            secondText == ""
                ? SmallText(
                    text: firstText,
                    size: 16,
                    color: AppColors.titleColor,
                  )
                : (hiddenText)
                    ? SmallText(
                        text: firstText, size: 16, )
                    : Column(
                        children: [
                          SmallText(
                              text: firstText, size: 16,  ),
                          SmallText(
                              text: secondText, size: 16,)
                        ],
                      ),
            secondText == ""
                ? Container()
                : InkWell(
                  onTap:(){
                    setState(() {
                      hiddenText=!hiddenText;
                    });
                  },
                  child: SmallText(
                     text: hiddenText? "show more ...":"show less ...",
                      color: Colors.green,
                    size:16
                    ),
                )
          ],
        ),
      ),
    );
  }
}
