import 'dart:async';

import 'package:get/get.dart';
import 'package:jzt_mt_project/routes/App_routes.dart';

class Splash_controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 5), () {
      Get.offNamed(Approutes.Homepage);
    });
  }
}
