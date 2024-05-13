import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Gemini/models/NewsModel.dart';

import '../../../data/apiClient/NewsApi/News_api.dart';

class NewsCOntroller extends GetxController {
  RxList<Articles> datas = <Articles>[].obs;
  final TextEditingController dataController = TextEditingController();
  final RxBool loading = true.obs;
  final RxString error = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchLatestNews();
  }

  Future<void> fetchLatestNews() async {
    try {
      loading.value = true;
      error.value = '';

      final fetchedProducts = await fetchAllNewsData("latest news");
      datas.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching latest news: $e');
      error.value = 'Failed to Load';
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchProductsFromApiFetchData() async {
    try {
      loading.value = true;
      error.value = '';

      final searchQuery = dataController.text;
      final fetchedProducts = await fetchAllNewsData(searchQuery);
      datas.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
      error.value = 'Failed to fetch data';
    } finally {
      loading.value = false;
    }
  }
}
