import 'package:flutter/material.dart';

class WeatherImage extends StatelessWidget {
  final String? weatherCode;
  final double size;
  final Widget? child;

  const WeatherImage({
    required this.weatherCode,
    this.size = 48.0,
    this.child,
  });

  String getIconAsset() {
    // Map weather condition codes to corresponding icon assets
    switch (weatherCode) {
      case '01d':
        return 'assets/sunrise.jpg';
      case '02d':
        return 'assets/daycloudy.jpg';
      case '03d':
      case '04d':
        return 'assets/cloudy.jpg';
      case '09d':
      case '10d':
        return 'assets/rainy.jpg';
      case '11d':
        return 'assets/thunder.jpg';
      case '13d':
        return 'assets/snow.jpeg';
      case '50d':
        return 'assets/fog.jpg';
      default:
        return 'assets/sunrise.jpg'; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getIconAsset()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
