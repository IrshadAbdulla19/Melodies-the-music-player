import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/resentplayed/resentlyplayed_bloc.dart';
import 'package:music_player/infrastructure/db/functions/functions.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

List<AllSongsLists> resentPlyedList = [];

Future<void> resentPlyed(int songId, BuildContext context) async {
  for (var element in AllSongsNotifier.value) {
    if (songId == element.songID) {
      resentPlyedList.insert(0, element);

      context
          .read<ResentlyplayedBloc>()
          .add(ResentplayedAddEvent(resentSong: resentPlyedList[0]));
    }
  }
}
