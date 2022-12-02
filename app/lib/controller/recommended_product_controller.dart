import 'package:app/model/product.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
final RecommendedProductRepo recommendedProductrep;
bool _isLoaded=false;
bool get isLoaded=>_isLoaded;
  RecommendedProductController({required this.recommendedProductrep});
  List<dynamic> _recommendedProductList=[];
  List<dynamic> get recommendedProductList=>_recommendedProductList;
  Future<void> getRecommendedProductList ()async {
    Response resoponse = await recommendedProductrep.getRecommendedProductList();
   if(resoponse.statusCode==200)
     {
       _recommendedProductList=[];
       _recommendedProductList.addAll(Product.fromJson(resoponse.body).products);
       bool _isLoaded=true;
       update();
     }}
}