import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final _URL_NEWS = 'https://newsapi.org/v2';
  final _API_KEY = 'd6641f5141294826bbca5fc68f63d3ed';

  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    print('Cargando Headlines');

    final url = '$_URL_NEWS/top-headlines?apiKey=$_API_KEY&country=us';

    final resp = await http.get(Uri.parse(url));
    final newsResponse = newsResponseFromJson(resp.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }
}
