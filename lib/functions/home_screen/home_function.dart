import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

final audioPlayer = AssetsAudioPlayer();
ValueNotifier<bool> isSongPlayingNotifier = ValueNotifier(false);

List<Audio> audioSongs = [];
// bool isSongPlaying = false;
// List<AllSongsLists> nowPlayinglist = [];
// AllSongsLists? nowPlay;

ChangeFormatesong(int index, List<AllSongsLists>? currentSongs) {
  // nowPlayinglist.clear();
  bool songOn = true;
  isSongPlayingNotifier.value = songOn;
  isSongPlayingNotifier.notifyListeners();
  // nowPlayinglist = currentSongs ?? nowPlayinglist;
  // nowPlay = currentSongs?[index];

  audioSongs.clear();
  if (currentSongs != null) {
    for (var element in currentSongs) {
      audioSongs.add(Audio.file(element.uri,
          metas: Metas(
            id: element.songID.toString(),
            artist: element.artist,
            title: element.name,
          )));

      // audioPlayer.play();
    }
  }
  audioPlayer.open(
      Playlist(
        audios: audioSongs,
        startIndex: index,
      ),
      loopMode: LoopMode.playlist,
      autoStart: true,
      showNotification: true);
}

AllSongsLists changeToSongModel(int songId) {
  late AllSongsLists data;
  for (var element in AllSongsNotifier.value) {
    if (element.songID == songId) {
      data = element;
      break;
    }
  }
  return data;
}
// audioPlayer.open(a
//   Playlist(audios: audioSongs, startIndex: index),
//   autoStart: false,
// );

// playsongs(int index) {
//   try {
//     audioPlayer.open(
//         Playlist(
//           audios: audioSongs,
//           startIndex: index,
//         ),
//         autoStart: false);
//   } catch (e) {
//     print('the error in the code is $e');
//   }
// }



// playSong(AllSongsLists song) {
//   audioPlayer.open(File(song.uri) as Playable);
//   audioPlayer.play();
// }
