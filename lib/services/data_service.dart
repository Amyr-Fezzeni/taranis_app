import 'dart:developer';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:taranis/models/news.dart';

class DataService {
  static String news = "https://packetstormsecurity.com/news/";

  static Future<List<News>> getAllNews() async {
    final response = await http.Client().get(Uri.parse(news));
    List<News> allNews = [];
    if (response.statusCode == 200) {
      try {
        var document =
            parser.parse(response.body).getElementsByClassName('news');

        for (var r in document) {
          String title = r.getElementsByTagName("dt").first.text.trim();
          String link = "https://packetstormsecurity.com" +
              r
                  .getElementsByTagName("dt")
                  .first
                  .getElementsByTagName("a")
                  .first
                  .attributes['href']
                  .toString();

          var lst = r.getElementsByTagName('dd').toList();
          String date = lst[0].getElementsByTagName('a').first.text;
          String source = lst[1].getElementsByTagName('a').first.text;
          String sourceLink = lst[1]
              .getElementsByTagName('a')
              .first
              .attributes['href']
              .toString();
          List<String> tags =
              lst[3].getElementsByTagName('a').map((tag) => tag.text).toList();

          News data = News(
              title: title,
              link: link,
              date: date,
              source: source,
              sourceLink: sourceLink,
              tags: tags);

          allNews.add(data);
        }
      } catch (e) {
        log("error parsing html : $e");
      }
    }
    return allNews;
  }

  static Future<List<News>> loadMoreNews(int page) async {
    String link = "https://packetstormsecurity.com/news/page$page/";
    final response = await http.Client().get(Uri.parse(link));
    List<News> allNews = [];
    if (response.statusCode == 200) {
      try {
        var document =
            parser.parse(response.body).getElementsByClassName('news');

        for (var r in document) {
          String title = r.getElementsByTagName("dt").first.text.trim();
          String link = "https://packetstormsecurity.com" +
              r
                  .getElementsByTagName("dt")
                  .first
                  .getElementsByTagName("a")
                  .first
                  .attributes['href']
                  .toString();

          var lst = r.getElementsByTagName('dd').toList();
          String date = lst[0].getElementsByTagName('a').first.text;
          String source = lst[1].getElementsByTagName('a').first.text;
          String sourceLink = lst[1]
              .getElementsByTagName('a')
              .first
              .attributes['href']
              .toString();
          List<String> tags =
              lst[3].getElementsByTagName('a').map((tag) => tag.text).toList();

          News data = News(
              title: title,
              link: link,
              date: date,
              source: source,
              sourceLink: sourceLink,
              tags: tags);

          allNews.add(data);
        }
      } catch (e) {
        log("error parsing html : $e");
      }
    }
    return allNews;
  }

  static Future<List<News>> loadCategoryNews(String category, int page) async {
    String link =
        "https://packetstormsecurity.com/news/tags/$category/page$page/";
    final response = await http.Client().get(Uri.parse(link));
    List<News> allNews = [];
    if (response.statusCode == 200) {
      try {
        var document =
            parser.parse(response.body).getElementsByClassName('news');

        for (var r in document) {
          String title = r.getElementsByTagName("dt").first.text.trim();
          String link = "https://packetstormsecurity.com" +
              r
                  .getElementsByTagName("dt")
                  .first
                  .getElementsByTagName("a")
                  .first
                  .attributes['href']
                  .toString();

          var lst = r.getElementsByTagName('dd').toList();
          String date = lst[0].getElementsByTagName('a').first.text;
          String source = lst[1].getElementsByTagName('a').first.text;
          String sourceLink = lst[1]
              .getElementsByTagName('a')
              .first
              .attributes['href']
              .toString();
          List<String> tags =
              lst[3].getElementsByTagName('a').map((tag) => tag.text).toList();

          News data = News(
              title: title,
              link: link,
              date: date,
              source: source,
              sourceLink: sourceLink,
              tags: tags);

          allNews.add(data);
        }
      } catch (e) {
        log("error parsing html : $e");
      }
    }
    return allNews;
  }
}
