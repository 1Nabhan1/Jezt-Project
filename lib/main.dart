import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jzt_mt_project/presentation/Movies_page/Movies_page.dart';
import 'package:jzt_mt_project/presentation/News_page/News_page.dart';
import 'package:jzt_mt_project/presentation/Splash_screen/Splash_screen.dart';
import 'package:jzt_mt_project/presentation/Splash_screen/controller/Splash_controller.dart';
import 'package:jzt_mt_project/presentation/Timezone_page/TimeZone/ListTimezone.dart';
import 'package:jzt_mt_project/routes/App_pages.dart';
import 'package:provider/provider.dart';

import 'core/constants/Theme_provider/Gemini_theme(provider).dart';
void main() async{
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp( ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      getPages: AppPages.List,
      home:
      GetBuilder<Splash_controller>(
        builder: (_) => Splash_screen(),
        init: Splash_controller(),
      ),
    );
  }
}
