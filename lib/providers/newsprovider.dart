import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mary_news/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:mary_news/models/news/News.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider() {
    
  }
  List<Article> newsdataall = [];
  Future getnewsdata() async {
    var url = Uri.parse(
        ApiUrl.newsapi); 
    var response = await http.get(url);
    print('response ${response.body}');

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      List<dynamic> articlesJson = jsonData['articles'];

      for (int i = 0; i < articlesJson.length; i++) {
        newsdataall.add(Article.fromJson(articlesJson[i]));
      }
    notifyListeners();

      return newsdataall;
      
    } else {
      print('Failed to load news data');
    }
  }
}
