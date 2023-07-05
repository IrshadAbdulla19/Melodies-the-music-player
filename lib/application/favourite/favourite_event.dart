part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class FavoutiesAddEvent extends FavouriteEvent {
  final AllSongsLists favSong;

  FavoutiesAddEvent({required this.favSong});
}

class FavoutieDeleteEvent extends FavouriteEvent {
  final AllSongsLists favSong;

  FavoutieDeleteEvent({required this.favSong});
}
