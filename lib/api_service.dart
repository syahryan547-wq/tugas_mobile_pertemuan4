import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class ApiService {
  static const _apiKey = 'fab58f80e19a4009b39c075550229980';  static const _baseUrl =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';
  Future<List<Article>> fetchArticles() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<dynamic> articlesJson = json['articles'];
        return articlesJson.map((e) => Article.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load articles (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server: $e');
    }
  }
}