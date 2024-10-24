import 'package:e_commerce/data/models/network_response.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:e_commerce/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class LogoutController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> logout() async {
    _inProgress = true;
    update();
    bool isSuccess = false;

    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Urls.logoutUrl);
    if (response.isSuccess) {
      _errorMessage = null;
      Get.find<AuthController>().clearUserData();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage!;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
