import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wikiapp/models/wiki_search_result/WikiSearchResult.dart';
import 'package:wikiapp/utils/api_endpoints.dart';

class WikiNetworkService {
  static Future<WikiSearchResult> getWikiPages(String search,
      {int gpsoffset = 0}) async {
    try {
      var _response = await http.get(Uri.parse(
        ApiEndPoints.wikiUrl(search, gpsoffset: gpsoffset),
      ));
      if (_response.statusCode == 200) {
        // SUCCESSFUL API CALL
        var _result = jsonDecode(_response.body);
        return WikiSearchResult.fromJson(_result);
      } else {
        // API call failed
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      // API call failed
      throw Exception("No Internet Connection");
    }
  }
}
