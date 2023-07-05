import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/mostplayed/mostplayed_bloc.dart';
import 'package:music_player/infrastructure/db/functions/functions.dart';

import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

List<AllSongsLists> mostPlayedList = [];
// List<AllSongsLists> mostPlaySortList = [];

Future<void> mostPlayAdd(int songID, BuildContext context) async {
  for (var element in AllSongsNotifier.value) {
    if (element.songID == songID) {
      mostPlayedList.insert(0, element);
      context
          .read<MostplayedBloc>()
          .add(MostplayedlistAddEvent(mostPlaySong: mostPlayedList[0]));
    }
  }
}
