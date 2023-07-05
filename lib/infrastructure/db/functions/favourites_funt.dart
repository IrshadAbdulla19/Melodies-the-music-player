import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

// ValueNotifier<List<AllSongsLists>> FavSongsNotifier = ValueNotifier([]);
List<AllSongsLists> allFavSongsList = [];
Future<void> getFavSongs() async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');
  allFavSongsList.clear();
  allFavSongsList.addAll(favsongdatabase.values);

  // FavSongsNotifier.value.clear();
  // FavSongsNotifier.value.addAll(favsongdatabase.values);
  // FavSongsNotifier.notifyListeners();
}

Future<void> addFavSongs(
  AllSongsLists? value,
) async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');

  bool flag = true;

  for (var element in favsongdatabase.values) {
    if (value?.songID == element.songID) {
      flag = false;
    }
  }
  if (flag == true && value != null) {
    final _keyId = await favsongdatabase.add(value);
    value.id = _keyId;
    getFavSongs();
  }
}

Future<void> addFavsongs(AllSongsLists? value, BuildContext contxt) async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');

  bool flag = true;

  for (var element in favsongdatabase.values) {
    if (value?.songID == element.songID) {
      flag = false;
    }
  }
  if (flag == true && value != null) {
    final _keyId = await favsongdatabase.add(value);
    value.id = _keyId;
    getFavSongs();
  }
}

Future<void> deleteFavSong(AllSongsLists? song) async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');
  bool check = false;
  int indx = 0;
  for (var element in favsongdatabase.values) {
    if (element.songID == song?.songID) {
      check = true;
      break;
    }
    indx++;
  }
  if (check == true) {
    favsongdatabase.deleteAt(indx);
  }
  getFavSongs();
}

isFav(AllSongsLists? value) {
  for (var element in allFavSongsList) {
    if (value?.songID == element.songID) {
      return true;
    }
  }
  return false;
}
