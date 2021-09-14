import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutternewsapp/models/article.dart';
import 'package:flutternewsapp/secret.dart';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=${apiKey}");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null &&
            element['author'] != null &&
            element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}

class NewsForCategory {
  List<Article> news = [];

  Future<void> getNewsForCategory(String category) async {
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    var url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}");

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['author'] != null && element['description'] != null) {
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}