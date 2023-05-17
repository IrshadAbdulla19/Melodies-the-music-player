import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

ValueNotifier<List<PlayListModel>> PlaylistNotifer = ValueNotifier([]);
Future<void> createPlaylistDB(PlayListModel playlistItem) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  final _playListId = await playlistDB.add(playlistItem);
  playlistItem.id = _playListId;
  getPlaylist();
}

Future<void> getPlaylist() async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  PlaylistNotifer.value.clear();
  PlaylistNotifer.value.addAll(playlistDB.values);
  PlaylistNotifer.notifyListeners();
}

Future<void> addSongsToPlaylist(
    PlayListModel playlistItem, AllSongsLists song) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  int index = 0;
  bool check = false;
  List<AllSongsLists> temp = [];
  for (var element in playlistDB.values) {
    if (playlistItem == element) {
      break;
    }
    index++;
  }
  String name = playlistItem.name;
  List<AllSongsLists> currentSongs = playlistItem.songs ?? temp;
  for (var element in currentSongs) {
    if (song.songID == element.songID) {
      check = true;
      break;
    }
  }
  if (check == false) {
    currentSongs.add(song);
  }
  PlayListModel newSong = PlayListModel(name: name, songs: currentSongs);
  playlistDB.putAt(index, newSong);
  // playlistDB.deleteAt(index);
  // final _playListId = await playlistDB.add(newSong);
  // playlistItem.id = _playListId;
  getPlaylist();
}

Future<void> deletePlaylist(
  int index,
  PlayListModel item,
) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  int indx = 0;
  for (var element in playlistDB.values) {
    if (element == item) {
      break;
    }
    indx++;
  }
  playlistDB.deleteAt(index);
  getPlaylist();
}

Future<void> updatePlaylistDB(PlayListModel newItem, int index) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  playlistDB.putAt(index, newItem);
  getPlaylist();
}

Future<void> removeSongFromDB(
    AllSongsLists? song, PlayListModel item, int playIndex) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  // int index = 0;
  bool check = false;
  List<AllSongsLists> temp = [];

  // for (var element in playlistDB.values) {
  //   if (element == item) {
  //     break;
  //   }
  //   index++;
  // }
  int songIdx = 0;
  String name = item.name;
  List<AllSongsLists> currentSongs = item.songs ?? temp;
  for (var element in currentSongs) {
    if (song?.songID == element.songID) {
      check = true;
      break;
    }
    songIdx++;
  }
  if (check == true) {
    currentSongs.removeAt(songIdx);
  }
  PlayListModel newSong = PlayListModel(name: name, songs: currentSongs);
  await playlistDB.putAt(playIndex, newSong);
  getPlaylist();
}

bool checkPlaylist(AllSongsLists song, int index) {
  PlayListModel item = PlaylistNotifer.value[index];
  List<AllSongsLists> temp = [];
  List<AllSongsLists> songs = item.songs ?? temp;
  for (var element in songs) {
    if (element.songID == song.songID) {
      return true;
    }
  }
  return false;
}
