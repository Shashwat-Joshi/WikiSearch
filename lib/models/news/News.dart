class News {
  final String sourceName;
  final String title;
  final String url;
  final String? urlToImage;
  final DateTime _publishedAt;

  News({
    required this.sourceName,
    required this.title,
    required this.url,
    required this.urlToImage,
    required DateTime publishedAt,
  }) : this._publishedAt = publishedAt;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      sourceName: json["source"]["name"],
      title: json["title"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.parse(json["publishedAt"]),
    );
  }

  String get createdBefore {
    Duration difference = DateTime.now().difference(this._publishedAt);
    return _calcCreatedBefore(difference);
  }

  /// [_calcCreatedBefore] is a simple logic to calculate the time difference
  String _calcCreatedBefore(Duration difference) {
    if (difference.inSeconds <= 59)
      return "${difference.inSeconds} sec";
    else if (difference.inSeconds >= 60 && difference.inMinutes <= 59)
      return "${difference.inMinutes} min";
    else if (difference.inMinutes >= 60 && difference.inHours <= 23)
      return difference.inHours <= 1
          ? "${difference.inHours} hour"
          : "${difference.inHours} hours";
    else {
      if (difference.inDays > 6) {
        int weeks = difference.inDays ~/ 7;
        return weeks <= 1 ? "$weeks week" : "$weeks weeks";
      } else {
        int days = (difference.inHours / 24).round();
        return days <= 1 ? "$days day" : "$days days";
      }
    }
  }
}
