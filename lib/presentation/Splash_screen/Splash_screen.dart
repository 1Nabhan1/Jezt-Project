import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Splash_screen/controller/Splash_controller.dart';

class Splash_screen extends StatelessWidget {
  Splash_screen({super.key});
  final Splash_controller splash_controller = Get.put(Splash_controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor:  const Color(0xFFFFCE6B),
      body: Center(
        child: Image.asset(
          'assets/Splash.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
