import 'dart:collection';
import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
part 'searchcache_state.dart';

class SearchcacheCubit extends Cubit<SearchcacheState> {
  Queue<String>? searchHistory;
  var _box = Hive.box("search-cache");

  SearchcacheCubit() : super(SearchcacheInitial());

  /// [populateSearchHistory] is a function that is used to populate [searchHistory] from local cache
  Future<void> populateSearchHistory() async {
    if (searchHistory == null) {
      // If searchHistory is null then only we'll initialize, if already initialized we don't need to
      // populate again
      List? result = await _box.get("search_history");
      if (result != null) {
        // If result found in cache populate searchHistory using result
        searchHistory = Queue.from(result);
      } else {
        // If result not found just initialize the queue
        searchHistory = Queue();
      }
    }
    emit(SearchcacheLoaded());
  }

  /// [updateSearchHistory] is a function that is used to update the search cache using a simple algo
  /// I wrote an algo such that:
  ///     1. Only top 10 items will stay in history.
  ///     2. If someone taps on search cache item it will come at the first position in queue
  Future<void> updateSearchHistory(String searchKeyword) async {
    if (searchHistory == null || searchHistory!.length == 0) {
      // If there is no prior search history init and add the keyword
      searchHistory = Queue();
      searchHistory!.add(searchKeyword);
    } else {
      if (searchHistory!.contains(searchKeyword)) {
        // If search history is there check whether keyword is already cached.
        // If it is already cached bring it at index 0
        searchHistory!.removeWhere((element) => element == searchKeyword);
        searchHistory!.addFirst(searchKeyword);
      } else {
        // If not present add it to the front of queue
        searchHistory!.addFirst(searchKeyword);
        // Search Cache will not be greater that 10 searches
        if (searchHistory!.length > 10) searchHistory!.removeLast();
      }
    }
    // Update the local cache after the algo is completed
    await _box.put("search_history", searchHistory!.toList());
    emit(SearchcacheLoaded());
  }
}
