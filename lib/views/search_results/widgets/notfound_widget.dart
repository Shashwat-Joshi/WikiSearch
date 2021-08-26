import 'package:flutter/material.dart';
import 'package:wikiapp/theme/app_theme.dart';

class NotFoundWidget extends StatelessWidget {
  final Size size;
  final String searchKeyword;

  const NotFoundWidget({
    required this.size,
    required this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 7.0),
        Container(
          width: size.width,
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          color: AppTheme.searchScreenBGColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We searched for - ",
                style: AppTheme.errorMessageSmallTextStyle,
              ),
              Container(
                width: size.width,
                height: 20.0,
                child: Text(
                  searchKeyword,
                  style: AppTheme.errorMessageSmallTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "and found no results on wikipedia",
                style: AppTheme.errorMessageSmallTextStyle,
              ),
              Text(
                "\nSuggestions :",
                style: AppTheme.errorMessageSmallTextStyle,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "\n\u2022 Make sure that all the words are spelled correctly.\n\u2022 Try different keywords.\n\u2022 Try more general keywords.\n\u2022 Go to stackoverflow.com",
                  style: AppTheme.errorMessageSmallTextStyle,
                ),
              ),
              SizedBox(height: 5)
            ],
          ),
        ),
      ],
    );
  }
}
