import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:wikiapp/models/wiki_search_result/WikiSearchResult.dart';
import 'package:wikiapp/models/wikipage/Wikipage.dart';
import 'package:wikiapp/repositories/repository.dart';
part 'wikisearch_state.dart';

class WikisearchCubit extends Cubit<WikisearchState> {
  // Pages currently being displayed
  List<WikiPage> pages = [];
  // Can be used for pagination later on !
  int _gpsOffSet = 0;

  Queue<Map<String, dynamic>> _articlesCache = Queue();
  var _box = Hive.box("news-articles-cache");

  WikisearchCubit() : super(WikisearchInitial());

  Future<void> fetchWikiPages(String searchKeyword,
      {bool isRefresh = false}) async {
    if (!isRefresh) emit(WikisearchInitial());
    try {
      WikiSearchResult searchResult =
          await Repository.searchWikiPages(searchKeyword);
      if (searchResult.gpsoffset == null) {
        emit(WikisearchNotFound());
      } else {
        // _gpsOffSet = searchResult.gpsoffset!;
        pages.clear();
        searchResult.pages.sort((a, b) => a.index.compareTo(b.index));
        searchResult.pages.forEach((page) {
          pages.add(page);
        });
        List? articles = _box.get("articles") ?? null;
        print(articles);
        if (articles != null) {
          _articlesCache.clear();
          articles.forEach((article) {
            _articlesCache.add(article);
          });
        }
        print(_articlesCache);
        updateLocalCache(searchKeyword);
        emit(WikisearchLoaded());
      }
    } catch (e) {
      bool _cacheAvailable = await getLocalCache(searchKeyword);
      print(_cacheAvailable.toString() + "\n\n\n\n");
      if (_cacheAvailable) {
        emit(WikisearchLoaded());
      } else {
        if (isRefresh) {
          throw Exception(
            "Failed to refresh, please check your network and try again!",
          );
        } else {
          emit(WikisearchError());
        }
      }
    }
  }

  Future<void> updateLocalCache(String searchKeyword) async {
    Map<String, dynamic> _cacheData = {
      "keyword": searchKeyword,
      "results": pages,
    };
    print(_cacheData);

    List _results = _articlesCache
        .where((article) => article["keyword"] == searchKeyword)
        .toList();

    if (_results.length == 0) {
      _articlesCache.addFirst(_cacheData);
      if (_articlesCache.length > 10) _articlesCache.removeLast();
    } else {
      _articlesCache
          .removeWhere((article) => article["keyword"] == searchKeyword);
      _articlesCache.addFirst(_cacheData);
    }

    await _box.put("articles", List.from(_articlesCache));
    var val = await _box.get("articles");
    print(val);
  }

  Future<bool> getLocalCache(String searchKeyword) async {
    List? articles = _box.get("articles") ?? null;
    print(articles);
    if (articles != null) {
      articles.forEach((article) {
        _articlesCache.add(article);
      });
      List filteredResult = _articlesCache
          .where((element) => element["keyword"] == searchKeyword)
          .toList();
      if (filteredResult.length != 0) {
        List articles = filteredResult.first["results"] as List;
        pages.clear();
        articles.forEach((page) {
          pages.add(page);
        });
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}

// [
//   {
    // keyword: "sachin",
    // results: [],
//   },
//   {
//     keyword: "bitcoin",
//     results: [],
//   },
//   {
//     keyword: "computer science",
//     results: [],
//   },
// ]
