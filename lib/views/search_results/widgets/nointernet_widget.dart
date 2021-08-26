import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:wikiapp/theme/app_theme.dart';

class NoInternetWidget extends StatelessWidget {
  final Size size;
  final Function callback;

  const NoInternetWidget({
    required this.size,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          width: size.width,
          decoration: BoxDecoration(
            color: AppTheme.searchScreenBGColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Lottie.asset(
                          "assets/nointernet.json",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(width: 30.0),
                    Container(
                      width: size.width - 170,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mobile data is off",
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "No data connection. Consider turning on mobile data or turning on Wi-Fi.",
                            style: GoogleFonts.montserrat(
                              color: Color(0xff8D9397),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: 1,
                color: Color(0xff444647),
              ),
              _getButtonTile(
                "Turn on Wi-Fi / mobile data",
                Icons.settings,
                size,
                () {
                  AppSettings.openWIFISettings();
                },
              ),
              Container(
                width: size.width,
                height: 1,
                color: Color(0xff444647),
              ),
              _getButtonTile(
                "Try again",
                Icons.refresh,
                size,
                () {
                  this.callback();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _getButtonTile(
        String text, IconData iconData, Size size, Function callback) =>
    Container(
      width: size.width,
      height: 50.0,
      child: MaterialButton(
        highlightColor: Color(0xff1D2328),
        splashColor: Colors.transparent,
        onPressed: () {
          callback();
        },
        child: Row(
          children: [
            Icon(
              iconData,
              color: Color(0xff737575),
            ),
            SizedBox(width: 10.0),
            Text(
              text,
              style: GoogleFonts.montserrat(
                color: Color(0xff737575),
              ),
            )
          ],
        ),
      ),
    );
