import 'dart:collection';
import 'package:flutter/material.dart';

class SearchHistoryList extends StatelessWidget {
  final Queue<String> searchHistory;
  final Size size;
  final Function callback;

  const SearchHistoryList({
    required this.searchHistory,
    required this.size,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return true;
      },
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            for (int search = 0; search < searchHistory.length; search++)
              Container(
                height: 50.0,
                child: MaterialButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  onPressed: () {
                    this.callback(searchHistory.elementAt(search));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.history),
                      SizedBox(width: 30.0),
                      Container(
                        width: size.width - 150.0,
                        child: Text(
                          searchHistory.elementAt(search),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: Icon(Icons.arrow_back),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
