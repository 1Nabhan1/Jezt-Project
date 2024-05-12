import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../presentation/Movies_page/models/Movie_model.dart';

Future<List<Search>> fetchAllDatas(String searchQuery) async {
  final Uri url = Uri.parse(
      'https://www.omdbapi.com/?s=$searchQuery&apikey=4ed24780');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataList = responseData['Search']; // Corrected key to 'Search'
    return dataList.map((json) => Search.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
