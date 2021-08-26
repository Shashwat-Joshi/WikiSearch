import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp/cubits/news/newscubit_cubit.dart';
import 'package:wikiapp/cubits/wiki_search_cubit/search_cache/searchcache_cubit.dart';
import 'package:wikiapp/cubits/wiki_search_cubit/wiki_search/wikisearch_cubit.dart';
import 'package:wikiapp/utils/screen_arguments.dart';
import 'package:wikiapp/views/home_screen/pages/home_screen.dart';
import 'package:wikiapp/views/search_results/pages/search_results.dart';
import 'package:wikiapp/views/search_screen/pages/search_screen.dart';
import 'package:wikiapp/views/splash_screen.dart';
import 'package:wikiapp/views/wiki_web_view.dart';

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
      case "/":
        return getPageRoute(SplashScreen());

      case "/home":
        return getMaterialRoute(
          BlocProvider(
            create: (context) => NewsCubit(),
            child: HomeScreen(),
          ),
        );

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
        final args = route.arguments as WebViewArgs;
        return getMaterialRoute(WikiWebView(url: args.url));
    }
  }
}
