import 'package:wikiapp/models/wiki_search_result/WikiSearchResult.dart';
import 'package:wikiapp/repositories/wiki_network_service.dart';

class Repository {
  static Future<WikiSearchResult> searchWikiPages(String searchKeyword) async {
    try {
      WikiSearchResult searchResult =
          await WikiNetworkService.getWikiPages(searchKeyword);
      return searchResult;
    } catch (e) {
      throw e;
    }
  }
}
