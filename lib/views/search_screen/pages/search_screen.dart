import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wikiapp/cubits/wiki_search_cubit/search_cache/searchcache_cubit.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/utils/screen_arguments.dart';
import 'package:wikiapp/views/search_screen/widgets/search_history_list.dart';

class SearchScreen extends StatefulWidget {
  final String? searchKeyword;

  const SearchScreen({required this.searchKeyword});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppTheme.searchScreenBGColor,
      systemNavigationBarColor: AppTheme.searchScreenBGColor,
    ));
    _textEditingController.text =
        widget.searchKeyword == null ? "" : widget.searchKeyword!;
    BlocProvider.of<SearchcacheCubit>(context).populateSearchHistory();
  }

  Future<void> _updateSearchCache(
      String searchKeyword, SearchcacheCubit cubit) async {
    await cubit.updateSearchHistory(searchKeyword);
    Navigator.pushReplacementNamed(
      context,
      "/wikiResults",
      arguments: WikiSearchArgs(
        searchKeyword: searchKeyword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SearchcacheCubit>(context);
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        if (widget.searchKeyword == null)
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: AppTheme.primaryColor,
            systemNavigationBarColor: AppTheme.primaryColor,
          ));
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: AppTheme.searchScreenBGColor,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                SizedBox(height: 5),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/wikilogo.png",
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        width: size.width - 130,
                        child: TextField(
                          controller: _textEditingController,
                          autofocus: true,
                          textInputAction: TextInputAction.search,
                          style: AppTheme.searchTextStyle.copyWith(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: AppTheme.searchTextStyle,
                            contentPadding: EdgeInsets.only(
                              left: 10.0,
                            ),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (searchKeyword) {
                            if (searchKeyword.length > 0) {
                              _updateSearchCache(searchKeyword, cubit);
                            }
                          },
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          _textEditingController.clear();
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Divider(),
                BlocBuilder<SearchcacheCubit, SearchcacheState>(
                  builder: (context, state) {
                    if (state is SearchcacheLoaded)
                      return Expanded(
                        child: SearchHistoryList(
                          searchHistory: cubit.searchHistory!,
                          size: size,
                          callback: (String searchText) {
                            setState(() {
                              _textEditingController.text = searchText;
                            });
                            _updateSearchCache(searchText, cubit);
                          },
                        ),
                      );
                    else
                      return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
