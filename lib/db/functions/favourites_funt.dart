import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

ValueNotifier<List<AllSongsLists>> FavSongsNotifier = ValueNotifier([]);

Future<void> getFavSongs() async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');
  FavSongsNotifier.value.clear();
  FavSongsNotifier.value.addAll(favsongdatabase.values);
  FavSongsNotifier.notifyListeners();
}

Future<void> addFavsongs(AllSongsLists? value, BuildContext contxt) async {
  final favsongdatabase = await Hive.openBox<AllSongsLists>('favsongs');
  // final favsong = AllSongsLists(
  //     name: value.name,
  //     artist: value.artist,
  //     uri: value.uri,
  //     songID: value.songID,
  //     duration: value.duration);
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
    // FavSongsNotifier.value.add(value);
    // FavSongsNotifier.notifyListeners();
    // print(favsongdatabase.keys);
    ScaffoldMessenger.of(contxt).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 11, 48, 78),
        content: Text('The song is add into Favourites'),
      ),
    );
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
  for (var element in FavSongsNotifier.value) {
    if (value?.songID == element.songID) {
      return true;
    }
  }
  return false;
}
