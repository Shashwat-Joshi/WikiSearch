import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wikiapp/models/wikipage/Wikipage.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/utils/api_endpoints.dart';
import 'package:wikiapp/utils/screen_arguments.dart';

class WikiTile extends StatelessWidget {
  final Size size;
  final WikiPage page;

  const WikiTile({
    required this.size,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 7.0),
      padding: EdgeInsets.only(bottom: 10.0),
      width: size.width,
      color: AppTheme.searchScreenBGColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10.0,
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/webview",
                arguments: WebViewArgs(url: page.fullurl),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/wikilogo.png",
                      height: 20.0,
                      width: 20.0,
                    ),
                    SizedBox(width: 15.0),
                    Container(
                      width: size.width - 60,
                      child: Text(
                        page.fullurl,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3),
                Text(
                  page.title,
                  style: AppTheme.headerStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 1,
                  width: size.width,
                  color: Color(0xff343638),
                ),
                SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 5),
                      width: page.thumbnail == null
                          ? size.width - 20
                          : size.width - 120,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          children: [
                            TextSpan(text: "Description: "),
                            TextSpan(
                              text: page.description != null
                                  ? page.description![0].toUpperCase() +
                                      page.description!.substring(1)
                                  : "Description not found",
                            ),
                          ],
                        ),
                      ),
                    ),
                    page.thumbnail == null
                        ? SizedBox()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              color: AppTheme.primaryColor,
                              child: CachedNetworkImage(
                                imageUrl: page.thumbnail!,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
