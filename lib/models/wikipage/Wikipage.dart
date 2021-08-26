class WikiPage {
  final int pageid, index;
  final String title;
  final String? thumbnail, description;
  final String fullurl;

  WikiPage({
    required this.pageid,
    required this.index,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.fullurl,
  });

  factory WikiPage.fromJson(Map<String, dynamic> json) {
    return WikiPage(
      pageid: json["pageid"] as int,
      index: json["index"] as int,
      title: json["title"],
      thumbnail:
          json.keys.contains("thumbnail") ? json["thumbnail"]["source"] : null,
      description:
          json.keys.contains("terms") ? json["terms"]["description"][0] : null,
      fullurl: json["fullurl"],
    );
  }
}
