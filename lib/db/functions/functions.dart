import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

ValueNotifier<List<SongsLists>> Favourites = ValueNotifier([]);

Future<void> getFavSongs(SongsLists value) async {
  final favSongDB = await Hive.openBox<SongsLists>('FavoutiesDB');
  Favourites.value.clear();
  Favourites.value.addAll(favSongDB.values);
  Favourites.notifyListeners();
}

Future<void> addFavSongs(SongsLists value) async {
  final favSongDB = await Hive.openBox('FavoutiesDB');
  final _id = await favSongDB.add(value);
  value.id = _id;
  Favourites.value.add(value);
  Favourites.notifyListeners();
}
