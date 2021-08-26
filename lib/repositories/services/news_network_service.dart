import 'dart:convert';
import 'package:wikiapp/models/news/News.dart';
import 'package:http/http.dart' as http;
import 'package:wikiapp/utils/api_endpoints.dart';

class NewsNetworkService {
  static Future<List<News>> getTopNews() async {
    try {
      var response = await http.get(Uri.parse(ApiEndPoints.newsApiUrl));
      if (response.statusCode == 200) {
        // SUCCESSFUL API CALL
        var result = jsonDecode(response.body);
        List newslist = result["articles"] as List;
        return newslist.map((news) => News.fromJson(news)).toList();
      } else {
        // API CALL FAILED
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      // API call failed
      throw Exception("No Internet Connection");
    }
  }
}
