import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/models/review_list_model.dart';
import 'package:e_commerce/data/models/review_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<ReviewModel> _reviewList = [];
  List<ReviewModel> get reviewList => _reviewList;

  Future<bool> getProductReview(int productId) async {
    _inProgress = true;
    update();
    bool isSuccess = false;
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getReviewList(productId: productId));
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
      _reviewList =
          ReviewListModel.fromJson(response.responseData).reviewList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
