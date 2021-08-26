import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp/cubits/wiki_search_cubit/wiki_search/wikisearch_cubit.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/views/search_results/widgets/nointernet_widget.dart';
import 'package:wikiapp/views/search_results/widgets/notfound_widget.dart';
import 'package:wikiapp/views/search_results/widgets/search_widget.dart';
import 'package:wikiapp/views/search_results/widgets/wiki_tile.dart';

class SearchResults extends StatefulWidget {
  final String searchKeyword;
  const SearchResults({required this.searchKeyword});

  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WikisearchCubit>(context)
        .fetchWikiPages(widget.searchKeyword);
  }

  Future<void> _refreshfetchWikiPages(WikisearchCubit cubit) async {
    try {
      await cubit.fetchWikiPages(widget.searchKeyword, isRefresh: true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<WikisearchCubit>(context);
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: AppTheme.primaryColor,
          systemNavigationBarColor: AppTheme.primaryColor,
        ));
        Navigator.pushReplacementNamed(context, "/home");
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: BlocBuilder<WikisearchCubit, WikisearchState>(
          builder: (context, state) => SafeArea(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SearchWidget(
                    size: size,
                    state: state,
                    searchKeyword: widget.searchKeyword,
                  ),
                  Expanded(
                    child: Container(
                      child: Scrollbar(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                            return true;
                          },
                          child: state is WikisearchError
                              ? _getBodyWidget(size, cubit, state)
                              : RefreshIndicator(
                                  onRefresh: () {
                                    return _refreshfetchWikiPages(cubit);
                                  },
                                  child: _getBodyWidget(size, cubit, state),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getBodyWidget(Size size, WikisearchCubit cubit, WikisearchState state) {
    return SizedBox(
      height: size.height - 188,
      width: size.width,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: _getSearchResultsWidget(size, cubit, state),
      ),
    );
  }

  _getSearchResultsWidget(
      Size size, WikisearchCubit cubit, WikisearchState state) {
    if (state is WikisearchLoaded) {
      return Column(
        children: [
          SizedBox(height: 7.0),
          for (int page = 0; page < cubit.pages.length; page++)
            WikiTile(size: size, page: cubit.pages[page])
        ],
      );
    } else if (state is WikisearchNotFound) {
      return NotFoundWidget(
        size: size,
        searchKeyword: widget.searchKeyword,
      );
    } else if (state is WikisearchError) {
      return NoInternetWidget(
        size: size,
        callback: () {
          cubit.fetchWikiPages(widget.searchKeyword);
        },
      );
    }
  }
}
