import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

ValueNotifier<List<AllSongsLists>> mostPlayedNotifer = ValueNotifier([]);

Future<void> addMostPlayedList(AllSongsLists song) async {
  final mostPlayedDB = await Hive.openBox<AllSongsLists>('most_played_db');
  int forCont = 0;
  int index = 0;

  for (var dbElements in mostPlayedDB.values) {
    if (song.songID == dbElements.songID) {
      forCont++;
      break;
    }
    index++;
  }

  if (forCont == 0) {
    song.count = 1;
    final _mostId = await mostPlayedDB.add(song);
    song.id = _mostId;
  } else {
    AllSongsLists? mostSong = mostPlayedDB.getAt(index);
    mostSong!.count = mostSong.count! + 1;
    mostPlayedDB.deleteAt(index);
    final _mostId = await mostPlayedDB.add(mostSong);
    song.id = _mostId;
  }
  getMostPlayed();
}

Future<void> getMostPlayed() async {
  final mostPlayedDB = await Hive.openBox<AllSongsLists>('most_played_db');
  mostPlayedNotifer.value.clear();
  mostPlayedNotifer.value.addAll(mostPlayedDB.values);
  AllSongsLists temp;
  for (var i = 0; i < mostPlayedNotifer.value.length; i++) {
    for (var j = i + 1; j < mostPlayedNotifer.value.length; j++) {
      if (mostPlayedNotifer.value[i].count! <
          mostPlayedNotifer.value[j].count!) {
        temp = mostPlayedNotifer.value[i];
        mostPlayedNotifer.value[i] = mostPlayedNotifer.value[j];
        mostPlayedNotifer.value[j] = temp;
      }
    }
  }
  mostPlayedNotifer.notifyListeners();
}
