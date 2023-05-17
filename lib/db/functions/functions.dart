import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<AllSongsLists>> AllSongsNotifier = ValueNotifier([]);

Future<void> getAllSongs() async {
  final allsongdatabase = await Hive.openBox<AllSongsLists>('allsong');
  AllSongsNotifier.value.clear();
  AllSongsNotifier.value.addAll(allsongdatabase.values);
  AllSongsNotifier.notifyListeners();
}

addallsongtodata(SongModel data) async {
  final allsongdatabase = await Hive.openBox<AllSongsLists>('allsong');
  final newsong = AllSongsLists(
      name: data.displayNameWOExt,
      artist: data.artist!,
      uri: data.uri!,
      songID: data.id,
      duration: data.duration!);
  bool flag = true;

  for (var element in allsongdatabase.values) {
    if (newsong.songID == element.songID) {
      flag = false;
    }
  }
  if (flag == true) {
    final _keyId = await allsongdatabase.add(newsong);
    newsong.id = _keyId;
    getAllSongs();
    AllSongsNotifier.value.add(newsong);
    AllSongsNotifier.notifyListeners();
    // print(allsongdatabase.values);
  }
}
