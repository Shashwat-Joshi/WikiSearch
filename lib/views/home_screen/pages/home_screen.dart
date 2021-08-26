import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:wikiapp/cubits/news/newscubit_cubit.dart';
import 'package:wikiapp/theme/app_theme.dart';
import 'package:wikiapp/views/home_screen/widgets/news_list.dart';
import 'package:wikiapp/views/search_results/widgets/nointernet_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsCubit>(context).getTopNews();
  }

  Future<void> _refreshData(NewsCubit cubit) async {
    try {
      await cubit.getTopNews(isRefresh: true);
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
    final cubit = BlocProvider.of<NewsCubit>(context);
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 2, right: 8),
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: Color(0xff333537),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                "https://openweathermap.org/img/wn/02d@2x.png",
                            errorWidget: (context, url, error) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                          Text("30° C")
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Wiki",
                                      style: AppTheme.logoStyle.copyWith(
                                        color: AppTheme.blueColor,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Search",
                                      style: AppTheme.logoStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.0),
                          SearchWidget(),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              BlocBuilder<NewsCubit, NewscubitState>(
                builder: (context, state) {
                  return _getNewsWidget(cubit, state, size);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getNewsWidget(NewsCubit cubit, NewscubitState state, Size size) {
    if (state is NewscubitLoaded) {
      return Expanded(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
            return true;
          },
          child: Scrollbar(
            child: RefreshIndicator(
              onRefresh: () {
                return _refreshData(cubit);
              },
              child: SingleChildScrollView(
                child: NewsList(cubit: cubit, size: size),
              ),
            ),
          ),
        ),
      );
    } else if (state is NewscubitError) {
      return NoInternetWidget(
        size: size,
        callback: () {
          cubit.getTopNews();
        },
      );
    } else {
      return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Lottie.asset("assets/loading.json"),
          ),
        ),
      );
    }
  }
}
