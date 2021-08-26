import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wikiapp/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 2, right: 8),
                // height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: Color(0xff333537),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: "https://openweathermap.org/img/wn/02d@2x.png",
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      height: 40.0,
                      width: 40.0,
                    ),
                    // Image.network(
                    //   "https://openweathermap.org/img/wn/02d@2x.png",
                    //   height: 40.0,
                    //   width: 40.0,
                    // ),
                    Text("30° C")
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      child: Center(
                        child: Text(
                          "WikiSearch",
                          style: AppTheme.logoStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 55,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/search");
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: AppTheme.searchButtonColor,
                        splashColor: Color(0xff585A5C),
                        highlightColor: Color(0xff585A5C).withOpacity(0.5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Color(0xff7A7E81),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "Search Wiki",
                              style: AppTheme.searchTextStyle,
                            ),
                            Spacer(),
                            Image.asset(
                              "images/wikilogo.png",
                              height: 40.0,
                              width: 40.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
