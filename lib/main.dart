import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wikiapp/routes/app_routes.dart';
import 'package:wikiapp/theme/app_theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("cache");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppTheme.primaryColor,
    systemNavigationBarColor: AppTheme.primaryColor,
  ));
  runApp(WikiSearch());
}

class WikiSearch extends StatelessWidget {
  const WikiSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      onGenerateRoute: AppRoutes.onGeneratedRoutes,
    );
  }
}
