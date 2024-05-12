import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/Weather_controller.dart';

class BuildAppBar extends StatelessWidget {
  const BuildAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());
    final weatherData = weatherController.weatherData.value;
    return AppBar(
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new)),
      backgroundColor: Colors.transparent,
      title: Text(
        ' ${weatherController.formatOriginalDate(weatherData?.dt as int?)}',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            weatherController.isSearching.value = true;
          },
        ),
      ],
    );
  }
}

class BuildSearchAppBar extends StatelessWidget {
  const BuildSearchAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());
    return AppBar(
      backgroundColor: Colors.transparent.withOpacity(.5),
      title: TextField(
        autofocus: true,
        style: TextStyle(color: Colors.white),
        controller: weatherController.cityController,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s")), // Deny whitespace
        ],
        decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          hintText: 'Search...',
          border: InputBorder.none,
        ),
        onSubmitted: (String value) {
          // Perform search operation here
        },
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.blueGrey,
        ),
        onPressed: () {
          weatherController.isSearching.value = false;
        },
      ),
      actions: [
        IconButton(
            onPressed: weatherController.getWeather,
            icon: Icon(
              Icons.send_outlined,
              color: Colors.blueGrey,
            ))
      ],
    );
  }
}
