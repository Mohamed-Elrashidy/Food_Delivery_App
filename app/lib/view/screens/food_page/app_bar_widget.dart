import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(
                text: "Bengladsh",
                color: AppColors.mainColor,
              ),
              Row(
                children: [
                  const SmallText(text: "Narishingdi"),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_drop_down))
                ],
              )
            ],
          ),
          InkWell(
            child: Container(height: 40,
            width: 40,
            decoration: BoxDecoration(color: AppColors.mainColor,

            borderRadius: BorderRadius.circular(12)),
            child: Icon(Icons.search,size:20),
            ),
          )
        ],
      ),
    );
  }
}
