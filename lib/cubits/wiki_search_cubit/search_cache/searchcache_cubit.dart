import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
part 'searchcache_state.dart';

class SearchcacheCubit extends Cubit<SearchcacheState> {
  Queue<String>? searchHistory;
  var _box = Hive.box("search-cache");

  SearchcacheCubit() : super(SearchcacheInitial());

  Future<void> populateSearchHistory() async {
    if (searchHistory == null) {
      List? result = await _box.get("search_history");
      if (result != null) {
        searchHistory = Queue.from(result);
      } else {
        searchHistory = Queue();
      }
    }
    emit(SearchcacheLoaded());
  }

  Future<void> updateSearchHistory(String searchKeyword) async {
    if (searchHistory == null || searchHistory!.length == 0) {
      searchHistory = Queue();
      searchHistory!.add(searchKeyword);
    } else {
      if (searchHistory!.contains(searchKeyword)) {
        searchHistory!.removeWhere((element) => element == searchKeyword);
        searchHistory!.addFirst(searchKeyword);
      } else {
        searchHistory!.addFirst(searchKeyword);
        if (searchHistory!.length > 10) searchHistory!.removeLast();
      }
    }
    await _box.put("search_history", searchHistory!.toList());
    emit(SearchcacheLoaded());
  }
}
