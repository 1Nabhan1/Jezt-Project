import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jzt_mt_project/presentation/Movies_page/Movies_page.dart';
import 'package:jzt_mt_project/presentation/home_screen/controller/Home_controller.dart';
import 'package:jzt_mt_project/routes/App_routes.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../Gemini/GeminiAi.dart';

class Home_page extends StatelessWidget {
  Home_page({super.key});
  final Home_controller home_controller = Get.put(Home_controller());
  final List<StaggeredTile> _staggeredTiles = [
    StaggeredTile.count(2, 3), // Large tile
    StaggeredTile.count(2, 2), // Medium tile
    StaggeredTile.count(2, 3), // Small tile
    StaggeredTile.count(2, 2), // Small tile
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Obx(
                  () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: Text(
                            home_controller.startText.value,
                            style: GoogleFonts.alice(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade300,
                                fontSize: 50),
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                width: double.infinity,
                child: Column(
                  children: [
                    StaggeredGridView.count(
                      padding: EdgeInsets.all(10),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      staggeredTiles: _staggeredTiles,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Approutes.WeatherPage);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/pexels-jplenio-1118873.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.pink.shade50),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 28.0, bottom: 30),
                                    child: Text("Weather",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Movies_page());
                          },
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Approutes.Moviespage);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/movies.jpg'),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.deepPurpleAccent),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(28.0),
                                      child: Text(
                                        "Movies",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Approutes.Timezonepage);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Time.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(25),
                                  color: CupertinoColors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Time Zone',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                    ]),
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Approutes.Newspage);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent.shade400,
                                  borderRadius: BorderRadius.circular(25),
                                  image: DecorationImage(
                                      image: AssetImage("assets/news.jpg"),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('News',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade700)),
                                    ]),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
          Obx(() {
            if (home_controller.showText.value) {
              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.04,
                right: MediaQuery.of(context).size.width * 0.18,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Hai! How can i help you today?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox
                  .shrink(); // To hide the text when showText is false
            }
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AiPage());
        },
        child: Image.asset(
          'assets/google-gemini-icon.png',
          fit: BoxFit.contain,
          width: 30,
        ),
      ),
    );
  }
}
