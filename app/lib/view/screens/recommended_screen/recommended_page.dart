
import 'package:flutter/material.dart';

import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';

class RecommendedPage extends StatelessWidget {
  const RecommendedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
body:CustomScrollView(
  slivers: [
    SliverAppBar(

      flexibleSpace: FlexibleSpaceBar(
        background:Image.asset("assets/image/food0.png"    ,    fit:BoxFit.cover,
        ),

      ),
      expandedHeight: Dimension.scaleHeight(250),
      pinned: true,
    title: Container(

      color: Colors.transparent,
      child:Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
 AppIcon(icon:Icons.highlight_remove_outlined),
 AppIcon(icon:Icons.shopping_cart_outlined)
          ]
        ),
      )
    ),
    )
  ],
)


    );
  }
}
