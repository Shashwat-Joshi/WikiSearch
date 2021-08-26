import 'package:flutter/material.dart';
import 'package:wikiapp/theme/app_theme.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, "/search");
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
            Text(
              "Search Wiki",
              style: AppTheme.searchTextStyle,
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
    );
  }
}
