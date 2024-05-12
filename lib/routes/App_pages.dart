import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Movies_page/Movies_page.dart';
import 'package:jzt_mt_project/presentation/News_page/News_page.dart';
import 'package:jzt_mt_project/presentation/Weather_page/Weather_page.dart';
import 'package:jzt_mt_project/presentation/home_screen/Home_page.dart';
import 'package:jzt_mt_project/routes/App_routes.dart';

import '../presentation/Timezone_page/TimeZone/ListTimezone.dart';

class AppPages {
  static var List = [
    GetPage(
      name: Approutes.Homepage,
      page: () => Home_page(),
    ),
    GetPage(
      name: Approutes.WeatherPage,
      page: () => WeatherPage(),
    ),
    GetPage(
      name: Approutes.Moviespage,
      page: () => Movies_page(),
    ),
    GetPage(
      name: Approutes.Newspage,
      page: () => NewsPage(),
    ),
    GetPage(
      name: Approutes.Timezonepage,
      page: () => Timezonelist(),
    )
  ];
}
