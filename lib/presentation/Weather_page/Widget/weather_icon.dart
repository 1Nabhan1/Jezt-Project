import 'package:flutter/cupertino.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIcon extends StatelessWidget {
  final String? weatherCode;
  final double size;

  const WeatherIcon({
    this.weatherCode,
    this.size = 48.0,
  });

  IconData getWeatherIcon() {
    // Map weather condition codes to corresponding weather_icons
    switch (weatherCode) {
      case '01d':
        return WeatherIcons.sunrise;
      case '02d':
        return WeatherIcons.day_cloudy;
      case '03d':
      case '04d':
        return WeatherIcons.cloudy;
      case '09d':
      case '10d':
        return WeatherIcons.rain;
      case '11d':
        return WeatherIcons.thunderstorm;
      case '13d':
        return WeatherIcons.snow;
      case '50d':
        return WeatherIcons.fog;
      default:
        return WeatherIcons.na; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      getWeatherIcon(),
      size: size,
      // You can customize other properties like color, alignment, etc. here
    );
  }
}
