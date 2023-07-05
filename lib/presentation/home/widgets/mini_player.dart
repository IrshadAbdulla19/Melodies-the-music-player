import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/most_played.dart';
import 'package:music_player/functions/library_functions/resent_played.dart';
import 'package:music_player/presentation/current_play/current_play_screen.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (cntx, playing) {
      resentPlyed(int.parse(playing.audio.audio.metas.id!), context);

      mostPlayAdd(int.parse(playing.audio.audio.metas.id!), context);
      return GestureDetector(
          onTap: () {
            // AllSongsLists song =
            //     changeToSongModel(int.parse(playing.audio.audio.metas.id!));
            // bool isFavSong = isFav(song);
            Navigator.push(context, MaterialPageRoute(builder: (cntx) {
              return CurrentPlayScreen();
            }));
          },
          child: Container(
            width: double.infinity,
            height: 80,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black,
                        child: QueryArtworkWidget(
                          id: int.parse(playing.audio.audio.metas.id!),
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Image.asset(
                            'asset/images/songe_screen.png',
                          ),
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: TextScroll(
                            playing.audio.audio.metas.title!,
                            velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                            pauseBetween: Duration(milliseconds: 1000),
                            style: songNameText,
                          ),
                        ),
                      ],
                    ),
                    // subtitle: Text('artist'),
                    subtitle: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              audioPlayer.previous();
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_previous_rounded)),
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (cntx, isPlaying) {
                              return IconButton(
                                  onPressed: () {
                                    if (isPlaying) {
                                      audioPlayer.pause();
                                    } else {
                                      audioPlayer.play();
                                    }
                                  },
                                  // iconSize: 30,
                                  color: Colors.white,
                                  icon: isPlaying
                                      ? Icon(Icons.pause)
                                      : Icon(Icons.play_arrow));
                            }),
                        IconButton(
                            onPressed: () {
                              audioPlayer.next();
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.skip_next_rounded)),
                        IconButton(
                            onPressed: () {
                              audioPlayer.stop();
                              // dispose();
                              setState(() {
                                isPlaying = false;
                                isSongPlayingNotifier.value = isPlaying;
                                isSongPlayingNotifier.notifyListeners();
                              });
                            },
                            color: Colors.white,
                            // iconSize: 35,
                            icon: Icon(Icons.stop)),
                      ],
                    ),
                  )),
            ),
          ));
    });
  }
}
