import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikiapp/models/news/News.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/utils/screen_arguments.dart';

class NewsTile extends StatelessWidget {
  final Size size;
  final News news;

  const NewsTile({
    required this.size,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      highlightColor: Color(0xff36383A),
      onPressed: () {
        Navigator.pushNamed(
          context,
          "/webview",
          arguments: WebViewArgs(url: news.url),
        );
      },
      child: Container(
        width: size.width,
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              height: 220.0,
              width: size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: news.urlToImage == null
                    ? Image.asset(
                        "images/news.jpg",
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: news.urlToImage!,
                        errorWidget: (context, url, error) => Image.asset(
                          "images/news.jpg",
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                news.title,
                style: AppTheme.headerStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18.0,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    news.sourceName,
                    style: GoogleFonts.montserrat(
                      color: Color(0xff787D81),
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "\u2023",
                    style: TextStyle(
                      color: Color(0xff787D81),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    news.createdBefore,
                    style: GoogleFonts.montserrat(
                      color: Color(0xff787D81),
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
