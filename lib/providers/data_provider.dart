import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:taranis/constants/data.dart';
import 'package:taranis/models/news.dart';
import 'package:taranis/services/data_service.dart';

class DataProvider with ChangeNotifier {
  List<News> allNews = [];
  List<News> filtredNews = [];
  List<News> backup = [];

  int newsPage = 1;
  int categoryPage = 1;

  bool isOffset = false;

  initNews() {
    newsPage = 1;
    getAllNews();
  }

  bool isLoawding = false;
  getAllNews() async {
    await Future.delayed(const Duration(milliseconds: 100));
    isLoawding = true;
    notifyListeners();
    allNews = await DataService.getAllNews();
    filtredNews = allNews;
    isLoawding = false;
    notifyListeners();
  }

  Future<void> loadMoreNews() async {
    isOffset = true;
    notifyListeners();
    newsPage += 1;
    List<News> newData = await DataService.loadMoreNews(newsPage);
    allNews.addAll(newData);
    filtredNews = allNews;
    isOffset = false;
    notifyListeners();
  }

  TextEditingController search = TextEditingController();

  clearSearch() {
    search.clear();
    filtredNews = allNews;
    notifyListeners();
  }

  filterSearch(context) {
    filtredNews = [];
    if (search.text.isEmpty) FocusScope.of(context).unfocus();
    filtredNews = backup
        .where((e) => e.title.toLowerCase().contains(search.text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  initCategory() {
    for (var c in categories) {
      c.isClicked = false;
    }
  }

  int currestCategoryKey = 0;

  initCategoryNews() {
    categoryPage = 1;
    currestCategoryKey = 0;
    filterCategory(0);
  }

  filterCategory(int key) async {
    categoryPage = 1;
    currestCategoryKey = key;
    isLoawding = true;
    initCategory();
    categories[key].isClicked = true;
    notifyListeners();
    if (key == 0) {
      allNews = await DataService.getAllNews();
    } else {
      allNews = await DataService.loadCategoryNews(
          categories[key].title, categoryPage);
    }
    filtredNews = allNews;
    backupData();
    isLoawding = false;
    notifyListeners();
  }

  loadMoreCategory() async {
    categoryPage += 1;
    isOffset = true;
    initCategory();
    categories[currestCategoryKey].isClicked = true;
    notifyListeners();
    if (currestCategoryKey == 0) {
      allNews.addAll(await DataService.getAllNews());
    } else {
      allNews.addAll(await DataService.loadCategoryNews(
          categories[currestCategoryKey].title, categoryPage));
    }
    filtredNews = allNews;
    backupData();
    isOffset = false;
    notifyListeners();
  }

  backupData() {
    backup.addAll(allNews.where((e) {
      for (var c in backup) {
        if (c.title == e.title) return false;
      }
      return true;
    }).toList());
    log(backup.length.toString());
  }
}
