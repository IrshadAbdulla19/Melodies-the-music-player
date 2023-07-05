part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class PlaylistCreateEvent extends PlaylistEvent {
  final String name;
  PlaylistCreateEvent({required this.name});
}

class PlaylistSongAddEvent extends PlaylistEvent {
  final PlayListModel playlist;
  final AllSongsLists song;

  PlaylistSongAddEvent({required this.playlist, required this.song});
}

class PlaylistUpdate extends PlaylistEvent {
  final PlayListModel playlist;
  final int index;
  final String name;
  PlaylistUpdate(
      {required this.index, required this.name, required this.playlist});
}

class PlaylistDeleteSong extends PlaylistEvent {
  final AllSongsLists? song;
  final PlayListModel playlist;
  final int index;

  PlaylistDeleteSong(
      {required this.song, required this.playlist, required this.index});
}

class PlaylistDeleteEvent extends PlaylistEvent {
  final PlayListModel playlist;
  final int index;

  PlaylistDeleteEvent({required this.playlist, required this.index});
}
