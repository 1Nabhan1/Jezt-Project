import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart'; // Import the get package
import '../../../presentation/Weather_page/models/Weather_model.dart'; // Import your WeatherModel class

class WeatherService extends GetxController {

  Future<WeatherModel> getWeatherByCity(String cityName) async {
    final String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=4a11e81e99ba9a8174234bcbc664d750&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        // Parse the JSON data into WeatherModel using its fromJson constructor
        final WeatherModel weatherModel = WeatherModel.fromJson(responseData);
        return weatherModel;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to fetch weather data: $e');
    }
  }
}