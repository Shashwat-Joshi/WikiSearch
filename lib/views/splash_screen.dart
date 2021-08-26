import 'package:flutter/material.dart';
import 'package:wikiapp/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      Navigator.pushReplacementNamed(context, "/home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250.0,
              height: 250.0,
              child: Image.asset("images/wikilogo.png"),
            ),
            SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Wiki",
                    style: AppTheme.logoStyle.copyWith(
                      color: AppTheme.blueColor,
                    ),
                  ),
                  TextSpan(
                    text: "Search",
                    style: AppTheme.logoStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
