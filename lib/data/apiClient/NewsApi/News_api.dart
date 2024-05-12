import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../presentation/Gemini/models/NewsModel.dart';
Future<NewsModel> fetchNews() async {
  final response = await http.get(
      Uri.parse('https://newsapi.org/v2/everything?q=technology&apiKey=687d0a3b364a402594f064c098af0fee'));
  if (response.statusCode == 200) {
    return NewsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load news');
  }
}
Future<List<Articles>> fetchAllNewsData(String searchQuery) async {
  final Uri url = Uri.parse(
      'https://newsapi.org/v2/everything?q=$searchQuery&apiKey=687d0a3b364a402594f064c098af0fee');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    final List<dynamic> dataList = responseData['articles']; // Corrected key to 'articles'
    return dataList.map((json) => Articles.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load news data');
  }
}