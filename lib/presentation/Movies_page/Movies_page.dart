import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:jzt_mt_project/presentation/Inner_page/Inner_page.dart';
import 'package:jzt_mt_project/presentation/Movies_page/controller/Movies_controller.dart';

class Movies_page extends StatelessWidget {
  Movies_page({super.key});
  final MoviesController moviesController = Get.put(MoviesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text(
          'Movies',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
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
              color: Colors.red,
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
                        controller: moviesController.dataController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'\s')), // Disallow spaces
                        ],
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
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(
                          MediaQuery.of(context).size.width * .12,
                          MediaQuery.of(context).size.height * .055,
                        ),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () async {
                        await moviesController.fetchProductsFromApiFetchData();
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () {
                if (moviesController.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (moviesController.error.value.isNotEmpty) {
                  return Column(
                    children: [
                      Text(
                        ' ${moviesController.error.value}',
                        style: TextStyle(fontSize: 20),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await moviesController
                              .fetchProductsFromApiFetchData();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  );
                } else {
                  return GridView.builder(
                    itemCount: moviesController.datas.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: MediaQuery.of(context).size.height * .24,
                    ),
                    itemBuilder: (context, index) {
                      final datas = moviesController.datas[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(InnerPage(
                            image: datas.poster!,
                            title: datas.title!,
                            description: datas.type!,
                            content: datas.year!,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .17,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    datas.poster ?? '',
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        .17,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Expanded(
                                  child: Text(
                                    datas.title ?? '',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
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
