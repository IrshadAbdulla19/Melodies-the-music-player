part of 'search_bloc.dart';

class SearchState {
  final int? searchIndex;
  final List<AllSongsLists> searchList;

  SearchState({this.searchIndex, required this.searchList});
}

class SearchInitial extends SearchState {
  SearchInitial() : super(searchList: allSongsLists, searchIndex: 0);
}
