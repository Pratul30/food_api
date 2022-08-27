
import 'package:rapyd_app/api/app.api.dart';
import 'package:rapyd_app/app/url.app.dart';
import 'package:rapyd_app/model/product.model.dart';

class ProductRepository {
  
  final AppApi _appApi = AppApi();
  
  Future<ProductModel> getAll() async {
    try {
      dynamic response = await _appApi.getAPI(url: "${UrlApp.baseUrl}/posts/1", headers: {});
      return response = ProductModel.fromJson(response);
    } catch (e) {
      rethrow ;
    }
  }
}