import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/play_controller.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatefulWidget {
  SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayController());

    return
        // ValueListenableBuilder(
        //   valueListenable: ,
        //   builder: (context, value, child) {
        //     return GestureDetector(
        //       child:
        FutureBuilder<List<SongModel>>(
            future: controller.audioquray.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL),
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No song is found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.separated(
                    itemBuilder: (cntx, indx) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (cntx) {
                            return CurrentPlayScreen(
                              currentSong: snapshot.data![indx],
                            );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            tileColor: Color.fromARGB(113, 37, 36, 36),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: QueryArtworkWidget(
                                id: snapshot.data![indx].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Icon(Icons.music_note),
                              ),
                              radius: 30,
                            ),
                            title: Text(
                              snapshot.data![indx].displayNameWOExt,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "${snapshot.data![indx].artist}",
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Wrap(
                              spacing: 1,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      controller
                                          .playSong(snapshot.data![indx].uri);
                                    },
                                    iconSize: 40,
                                    color: Colors.white,
                                    icon: Icon(Icons.play_circle)),
                                PopupMenuButton(
                                    color: Colors.white,
                                    surfaceTintColor: Colors.black,
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Add Playlist'),
                                              IconButton(
                                                  onPressed: () {
                                                    bottomSheet(context);
                                                  },
                                                  icon:
                                                      Icon(Icons.playlist_add)),
                                            ],
                                          )),
                                          PopupMenuItem(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Add to favourites'),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.favorite))
                                            ],
                                          ))
                                        ])
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (cntx, indx) {
                      return Divider();
                    },
                    itemCount: snapshot.data!.length);
              }
            });
    // );
    // },
    // );
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
