import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/favourites_funt.dart';

import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/most_played.dart';
import 'package:music_player/functions/library_functions/resent_played.dart';

import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/library_screen/playlist/add_new_playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';

class CurrentPlayScreen extends StatefulWidget {
  CurrentPlayScreen({
    super.key,
  });

  @override
  State<CurrentPlayScreen> createState() => _CurrentPlayScreenState();
}

class _CurrentPlayScreenState extends State<CurrentPlayScreen> {
  bool isLoop = true;
  bool isSuffle = true;
  Duration currentDuration = Duration(seconds: 0);
  Duration duration = Duration(seconds: 0);
  Duration songDuration = Duration();
  double sliderValue = 0.0;
  double maxSliderValue = 0.0;
  String mm = '';
  String ss = '';

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentDuration();
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   audioPlayer.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: audioPlayer.builderCurrent(builder: (cntx, playing) {
          resentPlyed(int.parse(playing.audio.audio.metas.id!));
          mostPlayAdd(int.parse(playing.audio.audio.metas.id!));
          AllSongsLists nowSong =
              changeToSongModel(int.parse(playing.audio.audio.metas.id!));
          bool isFavsong = isFav(nowSong);

          return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/images (1).jpeg'),
                      fit: BoxFit.cover)),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: SafeArea(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_sharp))),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: _mediaQuary.size.height * 0.5,
                                    child: QueryArtworkWidget(
                                      artworkBorder: BorderRadius.circular(10),
                                      id: int.parse(
                                          playing.audio.audio.metas.id!),
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Image.asset(
                                        'asset/images/songe_screen.png',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 3,
                            child: Container(
                                child: Card(
                              shadowColor: Colors.white,
                              elevation: 10,
                              child: Container(
                                height: _mediaQuary.size.height * 0.4,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'asset/images/images (1).jpeg'),
                                        fit: BoxFit.cover)),
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0, top: 15),
                                                  child: TextScroll(
                                                    playing.audio.audio.metas
                                                        .title!,
                                                    style: songNameText,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    bottomSheet(
                                                        context, nowSong);
                                                  },
                                                  icon:
                                                      Icon(Icons.playlist_add)),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isLoop) {
                                                        audioPlayer.setLoopMode(
                                                            LoopMode.single);
                                                        isLoop = !isLoop;
                                                      } else {
                                                        audioPlayer.setLoopMode(
                                                            LoopMode.playlist);
                                                        isLoop = !isLoop;
                                                      }
                                                    });
                                                  },
                                                  // iconSize: 30,
                                                  // color: Colors.white,
                                                  icon: isLoop
                                                      ? Icon(
                                                          Icons.replay_rounded,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons.replay_rounded,
                                                          color: Colors.blue,
                                                        )),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isSuffle) {
                                                        audioPlayer
                                                            .toggleShuffle();
                                                        isSuffle = !isSuffle;
                                                      } else {
                                                        audioPlayer
                                                            .toggleShuffle();
                                                        isSuffle = !isSuffle;
                                                      }
                                                    });
                                                  },
                                                  // iconSize: 30,
                                                  // color: Colors.white,
                                                  icon: isSuffle
                                                      ? Icon(
                                                          Icons.shuffle_rounded,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons.shuffle_rounded,
                                                          color: Colors.blue,
                                                        )),
                                              IconButton(
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      if (isFavsong) {
                                                        deleteFavSong(nowSong);
                                                        isFavsong = !isFavsong;
                                                      } else {
                                                        addFavsongs(
                                                            nowSong, context);
                                                        isFavsong = !isFavsong;
                                                      }
                                                    });
                                                  },
                                                  icon: !isFavsong
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.white,
                                                        )
                                                      : const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )),
                                            ],
                                          ),
                                          ForSlider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              PlayerBuilder.currentPosition(
                                                  player: audioPlayer,
                                                  builder: (cntx, position) {
                                                    currentDuration = position;
                                                    mm = (currentDuration
                                                                .inMinutes %
                                                            60)
                                                        .toString()
                                                        .padLeft(2, '0');
                                                    ss = (currentDuration
                                                                .inSeconds %
                                                            60)
                                                        .toString()
                                                        .padLeft(2, '0');
                                                    return Text(
                                                      '$mm:$ss',
                                                      style: artistNameText,
                                                    );
                                                  }),
                                              PlayerBuilder.current(
                                                  player: audioPlayer,
                                                  builder: (cntx, playing) {
                                                    songDuration =
                                                        playing.audio.duration;
                                                    mm = (songDuration
                                                                .inMinutes %
                                                            60)
                                                        .toString()
                                                        .padLeft(2, '0');
                                                    ss = (songDuration
                                                                .inSeconds %
                                                            60)
                                                        .toString()
                                                        .padLeft(2, '0');
                                                    return Text(
                                                      '$mm:$ss',
                                                      style: artistNameText,
                                                    );
                                                  }),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.previous();
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(Icons
                                                      .skip_previous_rounded)),
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.seekBy(
                                                        Duration(seconds: -10));
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(Icons.replay_10)),
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
                                                            : Icon(Icons
                                                                .play_arrow));
                                                  }),
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.seekBy(
                                                        Duration(seconds: 10));
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(Icons
                                                      .forward_10_outlined)),
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.next();
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(
                                                      Icons.skip_next_rounded)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )))
                      ],
                    ),
                  )),
                ),
              ));
        }));
  }

  Future bottomSheet(BuildContext cntx, AllSongsLists song) {
    return showModalBottomSheet(
        context: cntx,
        builder: (BuildContext context) {
          var mediaQuary = MediaQuery.of(context);
          return Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/images (2).jpeg'),
                      fit: BoxFit.cover)),
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: mediaQuary.size.height * 0.06,
                            width: mediaQuary.size.width * 0.5,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (cntx1) {
                                    return PlaylistAdd();
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 6, 59, 102),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Create playlist",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Icon(
                                      Icons.add,
                                      size: 15,
                                    )
                                  ],
                                )),
                          ),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: PlaylistNotifer,
                              builder: (BuildContext context,
                                  List<PlayListModel> playlistList,
                                  Widget? child) {
                                return ListView.builder(
                                    itemCount: playlistList.length,
                                    itemBuilder: (cntx, indx) {
                                      var playlist = playlistList[indx];
                                      bool isInPlaylist =
                                          checkPlaylist(song, indx);
                                      return Card(
                                        color: Color.fromARGB(255, 33, 87, 158),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                playlist.name,
                                                style: songNameText,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      if (!isInPlaylist) {
                                                        addSongsToPlaylist(
                                                            playlistList[indx],
                                                            song);
                                                        isInPlaylist =
                                                            !isInPlaylist;
                                                      } else {
                                                        removeSongFromDB(song,
                                                            playlist, indx);
                                                        isInPlaylist =
                                                            !isInPlaylist;
                                                      }
                                                    });
                                                  },
                                                  icon: !isInPlaylist
                                                      ? Icon(
                                                          Icons.add_circle,
                                                          color: Colors.white,
                                                        )
                                                      : Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        ))
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ],
                      ))));
        });
  }
}

class ForSlider extends StatefulWidget {
  const ForSlider({super.key});

  @override
  State<ForSlider> createState() => _ForSliderState();
}

class _ForSliderState extends State<ForSlider> {
  Duration currentDuration = Duration(seconds: 0);

  Duration duration = Duration(seconds: 0);

  Duration songDuration = Duration();

  double sliderValue = 0.0;

  double maxSliderValue = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.current.listen(
      (playing) {
        // setState(() {
        if (playing != null) {
          duration = playing.audio.duration;
          maxSliderValue = playing.audio.duration.inSeconds.toDouble();
        }
        // });
      },
    );
  }

  // @override
  @override
  Widget build(BuildContext context) {
    // audioPlayer.currentPosition.listen((position) {
    //   setState(() {
    //     sliderValue = position.inSeconds.toDouble();
    //   });
    // });

    return PlayerBuilder.currentPosition(
      player: audioPlayer,
      builder: (context, position) {
        sliderValue = position.inSeconds.toDouble();
        return Slider(
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          min: 0.0,
          value: sliderValue,
          max: maxSliderValue,
          onChanged: (newValue) {
            // setState(() {
            sliderValue = newValue;
            audioPlayer.seek(Duration(seconds: newValue.toInt()));
            // });
          },
        );
      },
    );
  }
}
