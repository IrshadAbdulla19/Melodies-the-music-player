import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<FavoutiesAddEvent>((event, emit) {
      addFavSongs(event.favSong);
      state.favoriteList = allFavSongsList;
      return emit(FavouriteState(favoriteList: state.favoriteList));
    });
    on<FavoutieDeleteEvent>((event, emit) {
      deleteFavSong(event.favSong);
      state.favoriteList = allFavSongsList;
      return emit(FavouriteState(favoriteList: state.favoriteList));
    });
  }
}
