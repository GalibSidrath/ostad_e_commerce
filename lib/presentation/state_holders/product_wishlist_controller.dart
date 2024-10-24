import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/models/product_wishlist_wrapper_model.dart';
import 'package:e_commerce/data/models/wishlist_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductWishlistController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;
  List<WishListModel> _wishList = [];
  List<WishListModel> get wishList => _wishList;

  Future<bool> getWishList() async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.productWishListUrl);

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      _wishList = ProductWishListWrapperModel.fromJson(response.responseData)
              .listOfWishList ??
          [];
    } else {
      _errorMessage = response.errorMessage!;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
