import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yaqeen/model/newsmodel.dart';

class ApiService {
  final String apiUrl = "https://yaqeen.onrender.com/api/news";

  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<Article> articles = [];

      for (var item in jsonData['data']) {
        articles.add(Article.fromJson(item));
      }
      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
