import 'package:flutter/material.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/songlists_db/playlist/play_list_model.dart';

// List<PlayListModel> playlistList = [];

Future<void> changeToPlaylist(String playListName, BuildContext context) async {
  String name = playListName;
  PlayListModel newPlaylist = PlayListModel(name: name);
  // creaetePlayList(newPlaylist);
  createPlaylistDB(newPlaylist, context);
}

Future<void> forPlayListCreate(
  String playListName,
) async {
  String name = playListName;
  PlayListModel newPlaylist = PlayListModel(name: name);
  // creaetePlayList(newPlaylist);
  createPlayListDB(
    newPlaylist,
  );
}

Future<void> updatePlaylist(
    String name, int index, PlayListModel item, BuildContext context) async {
  PlayListModel newOne = PlayListModel(name: name, songs: item.songs);
  updatePlaylistDB(newOne, index, context);
}

Future<void> updatePlayList(
  String name,
  int index,
  PlayListModel item,
) async {
  PlayListModel newOne = PlayListModel(name: name, songs: item.songs);
  updatePlayListDB(newOne, index);
}
