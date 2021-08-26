class ApiEndPoints {
  static String wikiUrl(String search, {int gpsoffset = 0}) =>
      "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms%7cinfo&inprop=url&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=200&pilimit=10&wbptterms=description&gpssearch=$search&gpsoffset=$gpsoffset";

  //FIXME: It would be better to use secret keys either from local assets or env but for time being I'm hardcoding it here itself.
  static String newsApiUrl =
      "https://newsapi.org/v2/top-headlines?country=in&pageSize=10&apiKey=75f8bb3e82c746bb9c413ce214a83317";
}
