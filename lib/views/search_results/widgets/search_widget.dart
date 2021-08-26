import 'package:flutter/material.dart';
import 'package:wikiapp/cubits/wiki_search_cubit/wiki_search/wikisearch_cubit.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/utils/screen_arguments.dart';

class SearchWidget extends StatelessWidget {
  final Size size;
  final WikisearchState state;
  final String searchKeyword;

  const SearchWidget({
    required this.size,
    required this.state,
    required this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      width: size.width,
      color: AppTheme.searchScreenBGColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "WikiSearch",
            style: AppTheme.logoStyle.copyWith(fontSize: 22.0),
          ),
          SizedBox(height: 30.0),
          Stack(
            clipBehavior: Clip.none,
            children: [
              state is WikisearchInitial
                  ? Positioned(
                      bottom: -2.0,
                      left: 35,
                      child: Container(
                        width: size.width - 67.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          child: LinearProgressIndicator(
                            color: AppTheme.blueColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                height: 55,
                child: MaterialButton(
                  elevation: 10.0,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/search",
                      arguments: WikiSearchArgs(
                        searchKeyword: searchKeyword,
                      ),
                    );
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
                      Container(
                        width: size.width - 126,
                        child: Text(
                          searchKeyword,
                          style: AppTheme.searchTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
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
        ],
      ),
    );
  }
}
