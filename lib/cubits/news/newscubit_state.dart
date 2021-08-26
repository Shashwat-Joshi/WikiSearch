part of 'newscubit_cubit.dart';

@immutable
abstract class NewscubitState {}

/// [NewscubitInitial] -> Loading state of news list
class NewscubitInitial extends NewscubitState {}

/// [NewscubitLoaded] -> Successful state i.e, when news list is successfully fetched
class NewscubitLoaded extends NewscubitState {}

/// [NewscubitError] -> Error state i.e, failed to fetch news list
class NewscubitError extends NewscubitState {}
