import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

// ValueNotifier<List<AllSongsLists>> resentPlyedNotifier = ValueNotifier([]);
List<AllSongsLists> resentPlayedListBloc = [];

Future<void> getResentPlyed() async {
  final resentDB = await Hive.openBox<AllSongsLists>('resent_db');
  resentPlayedListBloc.clear();
  resentPlayedListBloc.addAll(resentDB.values);
  // resentPlayedListBloc.reversed;
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
