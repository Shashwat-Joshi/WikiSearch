import 'package:flutter/material.dart';
import 'package:wikiapp/cubits/news/newscubit_cubit.dart';
import 'package:wikiapp/theme/app_theme.dart';

import 'news_tile.dart';

class NewsList extends StatelessWidget {
  final NewsCubit cubit;
  final Size size;

  const NewsList({
    required this.cubit,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Text(
            "News Headlines",
            style: AppTheme.headerStyle,
          ),
        ),
        SizedBox(height: 25.0),
        for (int news = 0; news < cubit.news.length; news++)
          Column(
            children: [
              NewsTile(
                size: size,
                news: cubit.news[news],
              ),
              Divider(),
            ],
          ),
      ],
    );
  }
}
