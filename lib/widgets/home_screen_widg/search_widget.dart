import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/settings_function/for_fetch_songs.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongSerach extends StatefulWidget {
  AllSongSerach({super.key, required this.songDisplay});
  List<AllSongsLists> songDisplay;
  @override
  State<AllSongSerach> createState() => _SongListState();
}

class _SongListState extends State<AllSongSerach> {
  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;

    return widget.songDisplay.isNotEmpty
        ? ListView.separated(
            itemBuilder: (cntx, indx) {
              var song = widget.songDisplay[indx];
              return GestureDetector(
                onTap: () {
                  // playsongs(indx);
                  ChangeFormatesong(indx, widget.songDisplay);
                  // Navigator.push(context, MaterialPageRoute(builder: (cntx) {
                  //   return CurrentPlayScreen();
                  // }));
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
                            style: songNameText,
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
                            style: artistNameText,
                          ),
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 1,
                      children: [
                        IconButton(
                            iconSize: 35,
                            color: Colors.white,
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.white,
                            )),

                        IconButton(
                            iconSize: 35,
                            color: Colors.white,
                            onPressed: () {
                              bottomSheet(context);
                            },
                            icon: Icon(Icons.playlist_add))
                        // IconButton(
                        //     onPressed: () {
                        //       if (isPlaying) {
                        //         audioPlayer.pause();
                        //         setState(() {
                        //           isPlaying = false;
                        //         });
                        //       } else {
                        //         audioPlayer.play();
                        //         setState(() {
                        //           isPlaying = true;
                        //         });
                        //       }
                        //     },
                        //     iconSize: 40,
                        //     color: Colors.white,
                        //     icon: isPlaying
                        //         ? Icon(Icons.pause)
                        //         : Icon(Icons.play_arrow)),
                        // PopupMenuButton(
                        //     color: Colors.white,
                        //     surfaceTintColor: Colors.black,
                        //     itemBuilder: (context) => [
                        //           PopupMenuItem(
                        //               child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text('Add Playlist'),
                        //               IconButton(
                        //                   onPressed: () {
                        //                     bottomSheet(context);
                        //                   },
                        //                   icon: Icon(Icons.playlist_add)),
                        //             ],
                        //           )),
                        //           PopupMenuItem(
                        //               child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text('Add to favourites'),
                        //               IconButton(
                        //                   onPressed: () {
                        //                     addFavsongs(song, context);
                        //                     Navigator.pop(context);
                        //                   },
                        //                   icon: Icon(Icons.favorite))
                        //             ],
                        //           ))
                        //         ])
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (cntx, indx) {
              return Divider();
            },
            itemCount: widget.songDisplay.length)
        : const Center(
            child: Text('No songa Found'),
          );
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
