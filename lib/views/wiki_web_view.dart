import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wikiapp/models/wikipage/Wikipage.dart';
import 'package:wikiapp/theme/app_theme.dart';

class WikiWebView extends StatefulWidget {
  final WikiPage wikiPage;

  const WikiWebView({
    required this.wikiPage,
  });

  @override
  _WikiWebViewState createState() => _WikiWebViewState();
}

class _WikiWebViewState extends State<WikiWebView> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.searchScreenBGColor,
        title: Text(
          "WikiSearch",
          style: GoogleFonts.montserrat(),
        ),
      ),
      body: WebView(
        onPageFinished: (val) {
          if (_isLoading) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        onPageStarted: (val) {
          if (!_isLoading) {
            setState(() {
              _isLoading = true;
            });
          }
        },
        onWebViewCreated: (controller) {
          _controller.complete(controller);
        },
        // initialUrl: ApiEndPoints.wikiPageUrl(widget.wikiPage.pageid),
        initialUrl: widget.wikiPage.fullurl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
