part of 'searchcache_cubit.dart';

@immutable
abstract class SearchcacheState {}

/// [SearchcacheInitial] -> Search Cache init/loading state
class SearchcacheInitial extends SearchcacheState {}

/// [SearchcacheLoaded] -> State when search cache is loaded
class SearchcacheLoaded extends SearchcacheState {}
