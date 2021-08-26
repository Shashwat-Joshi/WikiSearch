class ApiEndPoints {
  static String wikiUrl(String search, {int gpsoffset = 0}) =>
      "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms%7cinfo&inprop=url&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=200&pilimit=10&wbptterms=description&gpssearch=$search&gpsoffset=$gpsoffset";
}
