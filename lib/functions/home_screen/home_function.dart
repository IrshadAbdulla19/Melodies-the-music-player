import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> addToFav(SongModel data) async {
  String? artistname = data.artist;
  String? uri = data.uri;
  String? songName = data.displayNameWOExt;
  int? id = data.id;

  // final favSong = AllSongsLists(
  //     name: songName,
  //     artist: artistname ?? 'artisName',
  //     uri: uri ?? 'uri',
  //     songID: id);
  // addFavSongs(favSong);
}
