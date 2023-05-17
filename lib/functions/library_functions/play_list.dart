import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

// List<PlayListModel> playlistList = [];

Future<void> changeToPlaylist(String playListName) async {
  String name = playListName;
  PlayListModel newPlaylist = PlayListModel(name: name);
  // creaetePlayList(newPlaylist);
  createPlaylistDB(newPlaylist);
}

Future<void> updatePlaylist(String name, int index, PlayListModel item) async {
  PlayListModel newOne = PlayListModel(name: name, songs: item.songs);
  updatePlaylistDB(newOne, index);
}
// Future<void> creaetePlayList(PlayListModel playlistItem) async {
//   playlistList.add(playlistItem);
// }

// Future<void> deleteplaylist(PlayListModel playlistItem) async {
//   playlistList.remove(playlistItem);
// }

// Future<void> addSongToPlaylist(
//     AllSongsLists song, PlayListModel playlistItem) async {
//   int index = 0;
//   bool check = false;
//   List<AllSongsLists> newList = [];
//   for (var element in playlistList) {
//     if (playlistItem == element) {
//       break;
//     }
//     index++;
//   }
//   String name = playlistItem.name;
//   List<AllSongsLists>? currentSongs = playlistItem.songs ?? newList;
//   for (var element in currentSongs) {
//     if (song.songID == element.songID) {
//       check = true;
//       break;
//     }
//   }
//   if (check == false) {
//     currentSongs.add(song);
//   }
//   PlayListModel newSong = PlayListModel(name: name, songs: currentSongs);

//   playlistList.removeAt(index);
//   playlistList.insert(index, newSong);
// }
