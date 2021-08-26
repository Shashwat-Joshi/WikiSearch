part of 'wikisearch_cubit.dart';

@immutable
abstract class WikisearchState {}

class WikisearchInitial extends WikisearchState {}

class WikisearchLoaded extends WikisearchState {}

class WikisearchNotFound extends WikisearchState {}

class WikisearchError extends WikisearchState {}
