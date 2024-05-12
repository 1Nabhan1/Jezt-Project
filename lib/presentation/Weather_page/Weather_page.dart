import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'Widget/Custom_appbar.dart';
import 'Widget/Custom_container.dart';
import 'Widget/Weather_image.dart';
import 'Widget/weather_icon.dart';
import 'controller/Weather_controller.dart';

class WeatherPage extends StatelessWidget {
  WeatherPage({super.key});

  final WeatherController weatherController = Get.put(WeatherController());

  @override
  Widget build(BuildContext context) {
    weatherController.getWeatherForDefaultCity();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        final weatherData = weatherController.weatherData.value;
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                width: double.infinity,
                height: 700,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: WeatherImage(
                    weatherCode: weatherData?.weather![0].icon,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          height: 78,
                          width: double.infinity,
                          child: weatherController.isSearching.value
                              ? BuildSearchAppBar()
                              : BuildAppBar(),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Obx(() {
                          final weatherData =
                              weatherController.weatherData.value;
                          if (weatherData != null) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${weatherData.main!.temp?.toStringAsFixed(1)}°C',
                                          style: TextStyle(
                                              fontSize: 70,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          ' ${weatherData.weather![0].description}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                        WeatherIcon(
                                            weatherCode:
                                            weatherData.weather![0].icon),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 300,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${weatherData.name}',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.compare_arrows,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return SpinKitFadingFour(
                              color: Colors.black,
                              size: 50.0,
                            );
                            // or you can show a loading indicator
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                final weatherData = weatherController.weatherData.value;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.wind_power_rounded,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Wind',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Text(
                                ' ${weatherData?.wind!.speed} km/h',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.merge_type_rounded,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Pressure',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Text(
                                ' ${weatherData?.main!.pressure} MB',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomContainer(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.water_drop_outlined,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  'Humidity',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              Text(
                                ' ${weatherData?.main!.humidity} %',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade800),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        title: Text('__________'),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
