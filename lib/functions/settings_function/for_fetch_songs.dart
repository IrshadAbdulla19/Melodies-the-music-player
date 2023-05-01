import 'package:flutter/material.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/widgets/favourite_screen/song_list_fav.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongFetch {
  final songQuary = OnAudioQuery();

  forCheckPermission() async {
    var permission = await Permission.storage.request();
    if (permission.isGranted) {
      return songQuary.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);
    } else {
      forCheckPermission();
    }
  }

  forAddToDB() {
    SongModel songs = forCheckPermission();
    for (var i = 0; i < songs.data.length; i++) {
      addToFav(songs.data[i] as SongModel);
    }
  }
}
