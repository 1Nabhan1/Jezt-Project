import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Movies_page/models/Movie_model.dart';

import '../../../data/apiClient/Movies_data_Api/Movies_api.dart';

class MoviesController extends GetxController {
  RxList<Search> datas = <Search>[].obs;
  final TextEditingController dataController = TextEditingController();

  final RxBool loading = true.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatest();
  }

  Future<void> fetchLatest() async {
    try {
      loading.value = true;
      error.value = '';

      final fetchedProducts =
          await fetchAllDatas("latest"); // Fetch latest movies
      datas.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching latest movies: $e');
      error.value = 'Failed to load';
    } finally {
      loading.value = false;
    }
  }

  Future<void> fetchProductsFromApiFetchData() async {
    try {
      loading.value = true;
      error.value = '';

      final searchQuery = dataController.text;
      final fetchedProducts = await fetchAllDatas(searchQuery);
      datas.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
      error.value = 'Failed to load';
    } finally {
      loading.value = false;
    }
  }

  void retryFetch() {
    fetchProductsFromApiFetchData();
  }
}
