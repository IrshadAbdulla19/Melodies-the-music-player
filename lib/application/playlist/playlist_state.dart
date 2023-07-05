part of 'playlist_bloc.dart';

class PlaylistState {
  List<PlayListModel> thisPlaylist;
  PlaylistState({required this.thisPlaylist});
}

class PlaylistInitial extends PlaylistState {
  PlaylistInitial() : super(thisPlaylist: playListBloc);
}
