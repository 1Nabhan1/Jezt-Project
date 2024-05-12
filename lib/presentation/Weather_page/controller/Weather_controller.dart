import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/apiClient/Weather_api/WeatherApi.dart';
import '../models/Weather_model.dart';

class WeatherController extends GetxController {
  RxBool isSearching = false.obs;
  final TextEditingController cityController = TextEditingController();
  final WeatherService weatherService = WeatherService();
  Rx<WeatherModel?> weatherData = Rx<WeatherModel?>(null);

  void onInit() {
    super.onInit();
    // Fetch weather data for "Kozhikode" during initialization
    getWeatherForDefaultCity();
  }

  void getWeatherForDefaultCity() async {
    try {
      final defaultCity = "Kozhikode";
      var data = await weatherService.getWeatherByCity(defaultCity);
      weatherData.value = data;
    } catch (e) {
      print('Error fetching default city weather: $e');
    }
  }

  void getWeather() async {
    try {
      final cityName = cityController.text;
      var data = await weatherService.getWeatherByCity(cityName);
      weatherData.value = data;
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  String formatOriginalDate(int? timestamp) {
    if (timestamp != null) {
      DateTime dateTime =
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);

      String formattedDate = DateFormat('dd MMMM').format(dateTime.toLocal());

      String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      String result = '$formattedDate $weekday';

      return result;
    } else {
      return '';
    }
  }
}
