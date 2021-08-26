part of 'searchcache_cubit.dart';

@immutable
abstract class SearchcacheState {}

class SearchcacheInitial extends SearchcacheState {}

class SearchcacheLoaded extends SearchcacheState {}
