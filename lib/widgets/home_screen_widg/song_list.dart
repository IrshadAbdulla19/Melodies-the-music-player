import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/controller/play_controller.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatefulWidget {
  SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late Box<AllSongsLists> allsongBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allsongBox = Hive.box<AllSongsLists>('allsong');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AllSongsNotifier,
        builder: (BuildContext context, List<AllSongsLists> allSongs,
            Widget? child) {
          return ListView.separated(
              itemBuilder: (cntx, indx) {
                var song = allSongs[indx];
                return GestureDetector(
                  onTap: () {
                    ChangeFormatesong(indx);
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
                          id: song.songID,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(Icons.music_note),
                        ),
                        radius: 30,
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              song.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              song.artist,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 1,
                        children: [
                          IconButton(
                              onPressed: () {},
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
                                            icon: Icon(Icons.playlist_add)),
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
              itemCount: allSongs.length);
        });
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
