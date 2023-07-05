part of 'favourite_bloc.dart';

class FavouriteState {
  List<AllSongsLists> favoriteList;

  FavouriteState({required this.favoriteList});
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial() : super(favoriteList: allFavSongsList);
}
