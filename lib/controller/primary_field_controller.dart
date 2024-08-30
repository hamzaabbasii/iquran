import 'package:get/get.dart';

class PrimaryFieldController extends GetxController {
  RxBool isPasswordVisible = false.obs;
  void togglePasswordVisibility()
  {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
