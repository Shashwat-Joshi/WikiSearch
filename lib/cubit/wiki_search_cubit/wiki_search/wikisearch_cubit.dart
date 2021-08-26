import 'package:bloc/bloc.dart';
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

  WikisearchCubit() : super(WikisearchInitial());

  Future<void> fetchWikiPages(String searchKeyword,
      {bool isRefresh = false}) async {
    emit(WikisearchInitial());
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
        emit(WikisearchLoaded());
      }
    } catch (e) {
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
