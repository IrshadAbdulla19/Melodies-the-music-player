import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/play_controller.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class CurrentPlayScreen extends StatefulWidget {
  CurrentPlayScreen({super.key, this.currentSong});
  SongModel? currentSong;

  @override
  State<CurrentPlayScreen> createState() => _CurrentPlayScreenState();
}

class _CurrentPlayScreenState extends State<CurrentPlayScreen> {
  var controller = Get.put(PlayController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                    id: widget.currentSong?.id ?? 0,
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
                                  //     borderRadius: BorderRadius.circular(80)),
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
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'asset/images/images (1).jpeg'),
                                      fit: BoxFit.cover)),
                              child: ClipRRect(
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
                                                padding: const EdgeInsets.only(
                                                    left: 25.0, top: 15),
                                                child: Text(
                                                  widget.currentSong
                                                          ?.displayNameWOExt ??
                                                      'song name',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      bottomSheet(context);
                                                    },
                                                    icon: Icon(
                                                        Icons.playlist_add)),
                                                IconButton(
                                                    color: Colors.white,
                                                    onPressed: () {},
                                                    icon: Icon(Icons.favorite))
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '00:00',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Slider.adaptive(
                                                activeColor: Colors.blue,
                                                inactiveColor: Colors.grey,
                                                min: 0.0,
                                                value: 2,
                                                max: 2,
                                                onChanged: (value) {}),
                                            Text(
                                              '03:05',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon:
                                                    Icon(Icons.replay_rounded)),
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(Icons
                                                    .skip_previous_rounded)),
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(
                                                    Icons.fast_rewind_sharp)),
                                            IconButton(
                                                onPressed: () {
                                                  controller.playSong(
                                                      widget.currentSong!.uri);
                                                },
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(Icons.play_circle)),
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(Icons.fast_forward)),
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(
                                                    Icons.skip_next_rounded)),
                                            IconButton(
                                                onPressed: () {},
                                                iconSize: 30,
                                                color: Colors.white,
                                                icon: Icon(
                                                    Icons.shuffle_rounded)),
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
            )));
  }

  Future bottomSheet(BuildContext cntx) {
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
                    child: ListView.builder(
                        itemCount: playlistNames.length,
                        itemBuilder: (cntx, indx) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(playlistNames[indx]),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add_circle))
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
        });
  }
}
