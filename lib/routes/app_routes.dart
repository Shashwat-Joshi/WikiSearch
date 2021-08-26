import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp/cubit/wiki_search_cubit/search_cache/searchcache_cubit.dart';
import 'package:wikiapp/cubit/wiki_search_cubit/wiki_search/wikisearch_cubit.dart';
import 'package:wikiapp/models/wikipage/Wikipage.dart';
import 'package:wikiapp/utils/screen_arguments.dart';
import 'package:wikiapp/view/home_screen.dart';
import 'package:wikiapp/view/search_results/pages/search_results.dart';
import 'package:wikiapp/view/search_screen/pages/search_screen.dart';
import 'package:wikiapp/view/wiki_web_view.dart';

class AppRoutes {
  static MaterialPageRoute getMaterialRoute(screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }

  static PageRouteBuilder getPageRoute(screen) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, _, __) => screen,
    );
  }

  static Route? onGeneratedRoutes(RouteSettings route) {
    switch (route.name) {
      // case "/":
      //   return getPageRoute(SplashScreen());
      case "/":
        return getMaterialRoute(HomeScreen());

      case "/search":
        final WikiSearchArgs? args = route.arguments as WikiSearchArgs?;
        return getMaterialRoute(
          BlocProvider(
            create: (context) => SearchcacheCubit(),
            child: SearchScreen(
              searchKeyword: args == null ? null : args.searchKeyword,
            ),
          ),
        );

      case "/wikiResults":
        final args = route.arguments as WikiSearchArgs;
        return getPageRoute(
          BlocProvider(
            create: (context) => WikisearchCubit(),
            child: SearchResults(searchKeyword: args.searchKeyword),
          ),
        );

      case "/webview":
        final args = route.arguments as WikiPage;
        return getMaterialRoute(WikiWebView(wikiPage: args));
    }
  }
}
