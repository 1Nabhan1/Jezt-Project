import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Inner_page/Inner_page.dart';
import 'package:jzt_mt_project/presentation/News_page/controller/News_controller.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});
  final NewsCOntroller newsController = Get.put(NewsCOntroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Latest News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * .055,
                      child: TextField(
                        autofocus: true,
                        controller: newsController.dataController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            prefixIcon: Icon(
                              Icons.segment,
                              color: Colors.blueGrey,
                            ),
                            hintText: 'Search here',
                            hintStyle: TextStyle(color: Colors.grey.shade800),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * .12,
                                MediaQuery.of(context).size.height * .055),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () async {
                          await newsController.fetchProductsFromApiFetchData();
                        },
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () {
                if (newsController.loading.value) {
                  return Column(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    CircularProgressIndicator(),
                  ]);
                } else if (newsController.error.value.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' ${newsController.error.value}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          await newsController.fetchProductsFromApiFetchData();
                        },
                        child: Text(
                          'Retry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: newsController.datas.length,
                    itemBuilder: (context, index) {
                      final datas = newsController.datas[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(InnerPage(
                              image: datas.urlToImage ?? '',
                              title: datas.title ?? '',
                              description: datas.description ?? '',
                              content: datas.content ?? '',
                              date: datas.publishedAt ?? '',
                            ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        datas.urlToImage ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        datas.title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(datas.description ?? ''),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
