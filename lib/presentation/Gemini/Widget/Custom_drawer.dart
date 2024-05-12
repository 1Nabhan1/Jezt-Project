import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/Theme_provider/Gemini_theme(provider).dart';
import '../../../data/apiClient/NewsApi/News_api.dart';
import '../models/NewsModel.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.ontap,
    required this.sendMessage,
  });
  final void Function()? ontap;
  final Function(String) sendMessage;
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Future<NewsModel> _newsFuture;
  @override
  void initState() {
    super.initState();
    _newsFuture = fetchNews(); // Fetch news data when the drawer initializes
  }

  Widget build(BuildContext context) {
    @override
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      backgroundColor: Colors.transparent,
      child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: themeProvider.darkModeEnabled
                        ? Colors.grey.shade900
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.pink
                            ], // Specify your gradient colors here
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Gemini',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .white, // Text color will be overridden by the shader mask
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: Icon(
                          Icons.open_in_new,
                          color: themeProvider.darkModeEnabled
                              ? Colors.white
                              : Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FutureBuilder<NewsModel>(
                future: _newsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while fetching data
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // If data is successfully fetched, display it in the second container
                    final articles = snapshot.data!.articles;
                    return Container(
                      decoration: BoxDecoration(
                        color: themeProvider.darkModeEnabled
                            ? Colors.grey.shade900
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: articles!.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            // Display the heading for the latest news
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Latest News',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.darkModeEnabled
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            );
                          } else {
                            final article = articles[index - 1];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.sendMessage(article.title ?? '');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        article.title ?? '',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: themeProvider.darkModeEnabled
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    );
                  }
                },
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Transform.rotate(
                            angle: -0.5,
                            child: Icon(
                              Icons.nightlight_outlined,
                              color: themeProvider.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Dark mode',
                            style: TextStyle(
                              fontSize: 18,
                              color: themeProvider.darkModeEnabled
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      CupertinoSwitch(
                        value: themeProvider.darkModeEnabled,
                        onChanged: (bool value) {
                          themeProvider.darkModeEnabled = value;
                        },
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: themeProvider.darkModeEnabled
                        ? Colors.grey.shade900
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: MediaQuery.of(context).size.height * 0.1,
              )
            ],
          )),
    );
  }
}
