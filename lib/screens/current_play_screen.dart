import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/most_played.dart';
import 'package:music_player/functions/library_functions/resent_played.dart';
import 'package:music_player/styles/style.dart';

import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CurrentPlayScreen extends StatefulWidget {
  CurrentPlayScreen({super.key, required this.song});
  AllSongsLists song;

  @override
  State<CurrentPlayScreen> createState() => _CurrentPlayScreenState();
}

class _CurrentPlayScreenState extends State<CurrentPlayScreen> {
  bool isPlaying = true;
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
    // audioPlayer.currentPosition.listen((position) {
    //   setState(() {
    //     sliderValue = position.inSeconds.toDouble();
    //   });
    // });
    // audioPlayer.current.listen(
    //   (playing) {
    //     setState(() {
    //       duration = playing!.audio.duration;
    //       maxSliderValue = playing.audio.duration.inSeconds.toDouble();
    //     });
    //   },
    // );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: audioPlayer.builderCurrent(builder: (cntx, playing) {
          // resentPlyed(int.parse(playing.audio.audio.metas.id!));

          // mostPlayAdd(int.parse(playing.audio.audio.metas.id!));
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 500,
                                    child: QueryArtworkWidget(
                                      id: int.parse(
                                          playing.audio.audio.metas.id!),
                                      type: ArtworkType.AUDIO,
                                      nullArtworkWidget: Image.asset(
                                        'asset/images/songe_screen.png',
                                      ),
                                    ),
                                    // decoration: BoxDecoration(
                                    //     image: DecorationImage(
                                    //         image: AssetImage(
                                    //             'asset/images/537fb671eab8eae744d3ee96.webp'),
                                    //         fit: BoxFit.cover),
                                    //     color: Colors.blue,
                                    //     borderRadius:
                                    //         BorderRadius.circular(80)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                child: Card(
                              shadowColor: Colors.white,
                              elevation: 10,
                              child: Container(
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
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 25.0, top: 15),
                                                  child: Text(
                                                    playing.audio.audio.metas
                                                        .title!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: songNameText,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {
                                                        bottomSheet(context,
                                                            widget.song);
                                                      },
                                                      icon: Icon(
                                                          Icons.playlist_add)),
                                                  IconButton(
                                                      color: Colors.white,
                                                      onPressed: () {},
                                                      icon:
                                                          Icon(Icons.favorite))
                                                ],
                                              ),
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
                                              // Slider(
                                              //   activeColor: Colors.blue,
                                              //   inactiveColor: Colors.grey,
                                              //   min: 0.0,
                                              //   value: sliderValue,
                                              //   max: maxSliderValue,
                                              //   onChanged: (newValue) {
                                              //     setState(() {
                                              //       sliderValue = newValue;
                                              //       audioPlayer.seek(Duration(
                                              //           seconds:
                                              //               newValue.toInt()));
                                              //     });
                                              //   },
                                              // ),
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
                                                MainAxisAlignment.center,
                                            children: [
                                              // IconButton(
                                              //     onPressed: () {
                                              //       audioPlayer.setLoopMode(
                                              //           LoopMode.single);
                                              //     },
                                              //     iconSize: 30,
                                              //     color: Colors.white,
                                              //     icon: Icon(
                                              //         Icons.replay_rounded)),
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.previous();
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(Icons
                                                      .skip_previous_rounded)),
                                              IconButton(
                                                  onPressed: () {},
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(
                                                      Icons.fast_rewind_sharp)),
                                              IconButton(
                                                  onPressed: () {
                                                    if (isPlaying) {
                                                      audioPlayer.pause();
                                                      setState(() {
                                                        isPlaying = false;
                                                      });
                                                    } else {
                                                      audioPlayer.play();
                                                      setState(() {
                                                        isPlaying = true;
                                                      });
                                                    }
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: isPlaying
                                                      ? Icon(Icons.pause)
                                                      : Icon(Icons.play_arrow)),
                                              IconButton(
                                                  onPressed: () {},
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon:
                                                      Icon(Icons.fast_forward)),
                                              IconButton(
                                                  onPressed: () {
                                                    audioPlayer.next();
                                                  },
                                                  // iconSize: 30,
                                                  color: Colors.white,
                                                  icon: Icon(
                                                      Icons.skip_next_rounded)),
                                              // IconButton(
                                              //     onPressed: () {},
                                              //     // iconSize: 30,
                                              //     color: Colors.white,
                                              //     icon: Icon(
                                              //         Icons.shuffle_rounded)),
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
          return SizedBox(
              height: 400,
              child: Column(
                children: [
                  Container(
                      color: Colors.grey,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.keyboard_arrow_down_sharp))),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: PlaylistNotifer,
                      builder: (BuildContext context,
                          List<PlayListModel> playlistList, Widget? child) {
                        return ListView.builder(
                            itemCount: playlistList.length,
                            itemBuilder: (cntx, indx) {
                              var playlist = playlistList[indx];
                              bool isInPlaylist = checkPlaylist(song, indx);
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
                                                    playlistList[indx], song);
                                                isInPlaylist = !isInPlaylist;
                                              } else {
                                                removeSongFromDB(
                                                    song, playlist, indx);
                                                isInPlaylist = !isInPlaylist;
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
              ));
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
  Widget build(BuildContext context) {
    audioPlayer.currentPosition.listen((position) {
      setState(() {
        sliderValue = position.inSeconds.toDouble();
      });
    });
    audioPlayer.current.listen(
      (playing) {
        setState(() {
          duration = playing!.audio.duration;
          maxSliderValue = playing.audio.duration.inSeconds.toDouble();
        });
      },
    );
    return Slider(
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
      min: 0.0,
      value: sliderValue,
      max: maxSliderValue,
      onChanged: (newValue) {
        setState(() {
          sliderValue = newValue;
          audioPlayer.seek(Duration(seconds: newValue.toInt()));
        });
      },
    );
  }
}
