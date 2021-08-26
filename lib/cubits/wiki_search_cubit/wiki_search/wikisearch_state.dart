part of 'wikisearch_cubit.dart';

@immutable
abstract class WikisearchState {}

/// [WikisearchInitial] -> Init/Loading State for wiki search results
class WikisearchInitial extends WikisearchState {}

/// [WikisearchLoaded] -> State when the results are successfully laoded
/// either from api or from cache
class WikisearchLoaded extends WikisearchState {}

/// [WikisearchNotFound] -> State when results for a particular keyword are not found
class WikisearchNotFound extends WikisearchState {}

/// [WikisearchError] -> No internet state
class WikisearchError extends WikisearchState {}
