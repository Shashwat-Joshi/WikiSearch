import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wikiapp/models/news/News.dart';
import 'package:wikiapp/repositories/repository.dart';

part 'newscubit_state.dart';

class NewsCubit extends Cubit<NewscubitState> {
  List<News> news = [];
  NewsCubit() : super(NewscubitInitial());

  Future<void> getTopNews({bool isRefresh = false}) async {
    if (!isRefresh) emit(NewscubitInitial());
    try {
      List<News> result = await Repository.getTopNews();
      news.clear();
      news = result;
      emit(NewscubitLoaded());
    } catch (e) {
      if (isRefresh) {
        throw Exception(
          "Failed to refresh, please check your network and try again!",
        );
      } else {
        emit(NewscubitError());
      }
    }
  }
}
