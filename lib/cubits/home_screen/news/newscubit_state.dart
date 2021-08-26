part of 'newscubit_cubit.dart';

@immutable
abstract class NewscubitState {}

class NewscubitInitial extends NewscubitState {}

class NewscubitLoaded extends NewscubitState {}

class NewscubitError extends NewscubitState {}
