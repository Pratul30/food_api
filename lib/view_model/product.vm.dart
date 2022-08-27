
import 'package:flutter/material.dart';
import 'package:rapyd_app/api/response.dart';
import 'package:rapyd_app/model/product.model.dart';
import 'package:rapyd_app/repository/product.repository.dart';

class ProductVM extends ChangeNotifier {
  final _productRepo = ProductRepository();

  APIResponse<ProductModel> productModel = APIResponse.loading();

  setProductModel(APIResponse<ProductModel> response){
    productModel = response ;
    notifyListeners();
  }


  Future<void> getProducts() async {

    setProductModel(APIResponse.loading());
    _productRepo.getAll().then((value){
      setProductModel(APIResponse.completed(value));
      print('success: 200');
    }).onError((error, stackTrace){
      setProductModel(APIResponse.error(error.toString()));
    });

  }


}
