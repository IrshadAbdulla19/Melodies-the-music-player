import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_player/functions/library_functions/play_list.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/songlists_db/playlist/play_list_model.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  PlaylistBloc() : super(PlaylistInitial()) {
    on<PlaylistCreateEvent>((event, emit) {
      forPlayListCreate(event.name);
      state.thisPlaylist = playListBloc;
      return emit(PlaylistState(thisPlaylist: state.thisPlaylist));
    });
    on<PlaylistSongAddEvent>((event, emit) {
      addSongsToPlaylist(event.playlist, event.song);
      state.thisPlaylist = playListBloc;
      return emit(PlaylistState(thisPlaylist: state.thisPlaylist));
    });
    on<PlaylistDeleteSong>((event, emit) {
      removeSongFromDB(event.song, event.playlist, event.index);
      state.thisPlaylist = playListBloc;
      return emit(PlaylistState(thisPlaylist: state.thisPlaylist));
    });
    on<PlaylistDeleteEvent>((event, emit) {
      deletePlaylist(event.index, event.playlist);
      state.thisPlaylist = playListBloc;
      return emit(PlaylistState(thisPlaylist: state.thisPlaylist));
    });
    on<PlaylistUpdate>((event, emit) {
      updatePlayList(event.name, event.index, event.playlist);
      state.thisPlaylist = playListBloc;
      return emit(PlaylistState(thisPlaylist: state.thisPlaylist));
    });
  }
}
