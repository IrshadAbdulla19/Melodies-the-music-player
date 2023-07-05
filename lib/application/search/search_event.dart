part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchIndex extends SearchEvent {
  final int index;

  SearchIndex({required this.index});
}

class SearchList extends SearchEvent {
  final String name;

  SearchList({required this.name});
}
