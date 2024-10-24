import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewPostController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> postProductReview(
      String description, int productId, double rating) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    Map<String, dynamic> requsetData = {
      "description": description,
      "product_id": productId,
      "rating": rating
    };
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.createProductReviewUrl, body: requsetData);
    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage =
          response.errorMessage ?? 'Something went wrong. Try again';
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
