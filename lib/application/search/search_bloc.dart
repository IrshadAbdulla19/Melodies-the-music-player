import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/infrastructure/db/functions/functions.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchIndex>((event, emit) {
      return emit(
          SearchState(searchList: state.searchList, searchIndex: event.index));
    });
    on<SearchList>((event, emit) {
      List<AllSongsLists> searchList = allSongsLists
          .where((element) =>
              element.name.toLowerCase().contains(event.name.toLowerCase()))
          .toList();
      return emit(
          SearchState(searchList: searchList, searchIndex: state.searchIndex));
    });
  }
}
