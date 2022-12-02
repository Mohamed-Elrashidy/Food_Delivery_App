import 'package:app/data/api/api_client.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';

class RecommendedProductRepo extends GetxService{
  ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response>getRecommendedProductList  ()
  async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}