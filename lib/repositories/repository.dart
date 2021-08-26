import 'package:wikiapp/models/news/News.dart';
import 'package:wikiapp/models/wiki_search_result/WikiSearchResult.dart';
import 'package:wikiapp/repositories/services/news_network_service.dart';
import 'package:wikiapp/repositories/services/wiki_network_service.dart';

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

  static Future<List<News>> getTopNews() async {
    try {
      List<News> news = await NewsNetworkService.getTopNews();
      return news;
    } catch (e) {
      throw e;
    }
  }
}
