import 'package:get/get.dart';

class Home_controller extends GetxController {
  RxBool showText = true.obs;
  RxString startText = "Welcome,\n Glad you are here".obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 10), () {
      showText.value = false;
    });
    Future.delayed(Duration(seconds: 4), () {
      startText.value = "Let's get started!";

    });
  }
}
