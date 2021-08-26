import 'package:wikiapp/models/wikipage/Wikipage.dart';

class WikiSearchResult {
  final int? gpsoffset;
  final List<WikiPage> pages;

  WikiSearchResult({
    required this.gpsoffset,
    required this.pages,
  });

  factory WikiSearchResult.fromJson(Map<String, dynamic> json) {
    List pages =
        json.keys.contains("query") ? json["query"]["pages"] as List : [];
    return WikiSearchResult(
        gpsoffset: json.keys.contains("continue")
            ? json["continue"]["gpsoffset"]
            : null,
        pages: pages.map((page) => WikiPage.fromJson(page)).toList());
  }
}
