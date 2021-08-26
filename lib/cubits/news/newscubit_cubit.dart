import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wikiapp/models/news/News.dart';
import 'package:wikiapp/repositories/repository.dart';

part 'newscubit_state.dart';

class NewsCubit extends Cubit<NewscubitState> {
  List<News> news = [];
  NewsCubit() : super(NewscubitInitial());

  /// [getTopNews] function is to populate the news data and respond accordingly
  /// isRefresh is used so that if the user does a pull to refresh we maintain our news list state.
  /// TODO: We can add caching here too for better UX
  Future<void> getTopNews({bool isRefresh = false}) async {
    if (!isRefresh) emit(NewscubitInitial());
    try {
      List<News> result = await Repository.getTopNews();
      news.clear();
      news = result;
      emit(NewscubitLoaded());
    } catch (e) {
      if (isRefresh) {
        // This exception is caught in view to show a Snackbar
        throw Exception(
          "Failed to refresh, please check your network and try again!",
        );
      } else {
        emit(NewscubitError());
      }
    }
  }
}
