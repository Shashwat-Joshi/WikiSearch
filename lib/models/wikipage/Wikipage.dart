import 'package:hive/hive.dart';

part 'Wikipage.g.dart';

@HiveType(typeId: 1)
class WikiPage {
  @HiveField(0)
  final int pageid;
  @HiveField(1)
  final int index;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String? thumbnail;
  @HiveField(4)
  final String? description;
  @HiveField(5)
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
