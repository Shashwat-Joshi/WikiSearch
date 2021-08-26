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

  // For Cache of articles
  Queue _articlesCache = Queue();
  var _box = Hive.box("news-articles-cache");

  WikisearchCubit() : super(WikisearchInitial());

  /// [fetchWikiPages] is a function that searches articles related to [searchKeyword] in Wikipedia
  /// and if fetching was successful it will cache this data
  Future<void> fetchWikiPages(String searchKeyword,
      {bool isRefresh = false}) async {
    if (!isRefresh) emit(WikisearchInitial());
    try {
      WikiSearchResult searchResult =
          await Repository.searchWikiPages(searchKeyword);
      if (searchResult.gpsoffset == null) {
        /// If [gpsoffset] is null it implies that results were not found
        emit(WikisearchNotFound());
      } else {
        /// Fetching data was successful, now populate and update cache

        // TODO: For pagination feature
        // _gpsOffSet = searchResult.gpsoffset!;
        pages.clear();
        searchResult.pages.sort((a, b) => a.index.compareTo(b.index));
        pages = searchResult.pages;

        // After adding the results to pages lets cache it !!
        updateLocalCache(searchKeyword);
        emit(WikisearchLoaded());
      }
    } catch (e) {
      if (isRefresh) {
        // If it was a pull to refresh then through an exception so that view can catch and display
        // a Snackbar
        throw Exception(
          "Failed to refresh, please check your network and try again!",
        );
      } else {
        // If it was not refresh then check if cache is available and emit the state accordingly
        bool _cacheAvailable = await getLocalCache(searchKeyword);
        if (_cacheAvailable) {
          emit(WikisearchLoaded());
        } else {
          emit(WikisearchError());
        }
      }
    }
  }

  /// [updateLocalCache] is a function that is used to update articles cache
  Future<void> updateLocalCache(String searchKeyword) async {
    /// Updating value of [_articlesCache] before actual logic as it will be required
    List? articles = _box.get("articles") ?? null;
    if (articles != null) {
      _articlesCache.clear();
      articles.forEach((article) {
        _articlesCache.add(article);
      });
    }

    // Format in which we'll be caching our data
    var _cacheData = {
      "keyword": searchKeyword,
      "results": pages,
    };

    /// Getting a list of results to see if cache for [searchKeyword] already exists.
    List _results = _articlesCache
        .where((article) => article["keyword"] == searchKeyword)
        .toList();

    if (_results.length == 0) {
      /// Cache for [searchKeyword] does not exist so add it to our queue's front
      _articlesCache.addFirst(_cacheData);
      // Again cache limit is set to 10
      if (_articlesCache.length > 10) _articlesCache.removeLast();
    } else {
      // If cache already present remove it from the queue and add again to update data.
      _articlesCache
          .removeWhere((article) => article["keyword"] == searchKeyword);
      _articlesCache.addFirst(_cacheData);
    }

    // After the algo is complete update the local cache
    await _box.put("articles", List.from(_articlesCache));
  }

  /// [getLocalCache] is to fetch local cache when internet connection is not available
  /// and then populate pages with cache
  /// [getLocalCache] returns [true] if cache for [searchKeyword] is available
  /// and [false] if not available.
  Future<bool> getLocalCache(String searchKeyword) async {
    List? articles = _box.get("articles") ?? null;
    if (articles != null) {
      // If cache is available populate queue
      articles.forEach((article) {
        _articlesCache.add(article);
      });

      /// Get the list of searchCache where keyword == [searchKeyword]
      List filteredResult = _articlesCache
          .where((element) => element["keyword"] == searchKeyword)
          .toList();

      if (filteredResult.length != 0) {
        /// Cache for [searchKeyword] found, so add this to our pages so that it can reflect changes
        /// to the view
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
