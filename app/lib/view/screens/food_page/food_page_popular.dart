import 'package:app/controller/recommended_product_controller.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/dimensionScale.dart';
import 'package:app/view/widgets/bit_text.dart';
import 'package:app/view/widgets/data_view.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../widgets/text_and_icon.dart';

class FoodPagePopular extends StatelessWidget {
  const FoodPagePopular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(),
        listWidget(),
      ],
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: EdgeInsets.only(left: Dimension.scaleWidth(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BigText(text: 'Recommended'),
          SizedBox(
            width: Dimension.scaleWidth(10),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 3), child: SmallText(text: '.')),
          SizedBox(
            width: Dimension.scaleWidth(10),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 3),
              child: SmallText(text: 'Food pairing'))
        ],
      ),
    );
  }

  Widget listWidget()    {
    return GetBuilder<RecommendedProductController>(builder:  (recommedndedProduct){
    //recommedndedProduct.getRecommendedProductList();
      return recommedndedProduct.isLoaded?  ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recommedndedProduct.recommendedProductList.length,
          itemBuilder: (_, index) => Container(
              margin: EdgeInsets.symmetric(
                  vertical: (Dimension.scaleHeight(10)),
                  horizontal: Dimension.scaleWidth(10)),
              child: GestureDetector(
                  onTap:(){
                    Get.toNamed(RouteHelper.recommendedFood,arguments: [ recommedndedProduct.recommendedProductList[index]]);
                  },

                  child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(Dimension.scaleHeight(20)),
                      child: Image.network(
                        AppConstants.BASE_URI+AppConstants.UPLOAD_URL+recommedndedProduct.recommendedProductList[index].img!,
                        fit: BoxFit.cover,
                        width: Dimension.scaleWidth(150),
                        height: Dimension.scaleWidth(150),
                        cacheWidth: (Dimension.scaleWidth(150).ceil()),
                        cacheHeight: (Dimension.scaleWidth(150).ceil()),
                      ),
                    ),
                    Expanded(
                      child: Container(

                          padding: EdgeInsets.all(Dimension.scaleHeight(10)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          height: Dimension.scaleHeight(90),

                            child:DataView(recommedndedProduct.recommendedProductList[index]),
                          ),
                    )
                  ],
                ),
              ))):CircularProgressIndicator();
    });
  }
}
