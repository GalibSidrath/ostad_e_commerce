import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/models/product_list_model.dart';
import 'package:e_commerce/data/models/product_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CategoryListByIdController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ProductModel> _productList = [];
  List<ProductModel> get productList => _productList;

  Future<bool> getCategoryListById({required int id}) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.categoryListById(categoryId: id));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
