import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CreateWishlistController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> createWishListProduct(int productId) async {
    _inProgress = true;
    update();
    bool isSuccess = true;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.createWishListUrl(productId: productId));

    if (response.isSuccess == true &&
        response.responseData['msg'] == 'success' &&
        response.responseData != null) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
