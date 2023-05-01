import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final songQuery = OnAudioQuery();
final audioPlayer = AssetsAudioPlayer();

List<SongModel> allsonglist = [];
List<SongModel> mp3songslist = [];
List<Audio> audio = [];
checkpermission() async {
  final permission = await Permission.storage.request();
  if (permission.isGranted) {
    allsonglist = await songQuery.querySongs();

    for (var element in allsonglist) {
      if (element.fileExtension == 'mp3') {
        mp3songslist.add(element);
      }
    }
    for (var element in mp3songslist) {
      addallsongtodata(element);
      // print(element);
    }
  } else {
    checkpermission();
  }
  // getFavSongs();
}

ChangeFormatesong(int index) {
  for (var element in AllSongsNotifier.value) {
    audio.add(Audio.file(element.uri,
        metas: Metas(
          id: element.id.toString(),
          artist: element.artist,
          title: element.name,
        )));
  }
  audioPlayer.open(
    Playlist(audios: audio, startIndex: index),
    autoStart: false,
  );
}
