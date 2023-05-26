import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

ValueNotifier<List<AllSongsLists>> resentPlyedNotifier = ValueNotifier([]);

Future<void> getResentPlyed() async {
  final resentDB = await Hive.openBox<AllSongsLists>('resent_db');
  resentPlyedNotifier.value.clear();
  // for (var dbVal in resentDB.values) {
  //   if (!resentPlyedNotifier.value.contains(dbVal)) {
  //     resentPlyedNotifier.value.insert(0, dbVal);
  //   } else {
  //     for (var resentVal in resentPlyedNotifier.value) {
  //       if (resentVal.songID == dbVal.songID) {
  //         resentPlyedNotifier.value.remove(resentVal);
  //         resentPlyedNotifier.value.insert(0, dbVal);
  //       }
  //     }
  //   }
  // }
  resentPlyedNotifier.value.addAll(resentDB.values);
  resentPlyedNotifier.value =
      List<AllSongsLists>.from(resentPlyedNotifier.value.reversed);
  resentPlyedNotifier.notifyListeners();
}

Future<void> addResentPlyed(AllSongsLists value) async {
  final resentDB = await Hive.openBox<AllSongsLists>('resent_db');
  int count = 0;
  int index = 0;
  for (var element in resentDB.values) {
    if (element.songID == value.songID) {
      resentDB.deleteAt(index);
    }
    index++;
  }

  final _resentID = await resentDB.add(value);
  value.id = _resentID;
  for (var element in resentDB.values) {
    count++;
  }
  if (count > 15) {
    resentDB.deleteAt(0);
  }
  getResentPlyed();
}
