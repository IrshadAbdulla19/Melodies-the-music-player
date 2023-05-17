import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/functions/most_played.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/most_played.dart';

import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/styles/style.dart';

import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayed extends StatefulWidget {
  const MostlyPlayed({super.key});

  @override
  State<MostlyPlayed> createState() => _MostlyPlayedState();
}

class _MostlyPlayedState extends State<MostlyPlayed> {
  late Box<AllSongsLists> mostPlayBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mostPlayBox = Hive.box('most_played_db');
  }

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.only(left: 8.0),
        //   child: Row(
        //     children: [
        //       Expanded(
        //           flex: 4,
        //           child: TextFormField(
        //             style: TextStyle(color: Colors.white),
        //             decoration: InputDecoration(
        //                 filled: true,
        //                 fillColor: Color.fromARGB(255, 6, 59, 102),
        //                 contentPadding: EdgeInsets.symmetric(
        //                     vertical: 10, horizontal: 10),
        //                 border: OutlineInputBorder(
        //                     borderRadius: BorderRadius.circular(28))),
        //           )),
        //       Expanded(
        //         flex: 1,
        //         child: CircleAvatar(
        //           child:
        //               IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        ValueListenableBuilder(
      valueListenable: mostPlayedNotifer,
      builder:
          (BuildContext cntx, List<AllSongsLists> mostSongs, Widget? child) {
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount:
                // mostPlayedList.length,
                mostSongs.length < 10 ? mostSongs.length : 10,
            itemBuilder: (cntx, indx) {
              var mostSong = mostSongs[indx];
              bool isFavSong = isFav(mostSong);
              return SongListMostlyPlayed(
                mostSongs: mostSongs,
                index: indx,
                mostSong: mostSong,
                isFavSong: isFavSong,
              );
            });
      },
    );
  }
}

class SongListMostlyPlayed extends StatefulWidget {
  SongListMostlyPlayed(
      {super.key,
      required this.mostSong,
      required this.index,
      required this.mostSongs,
      required this.isFavSong});
  AllSongsLists mostSong;
  int index;
  List<AllSongsLists> mostSongs;
  bool isFavSong;

  @override
  State<SongListMostlyPlayed> createState() => _SongListMostlyPlayedState();
}

class _SongListMostlyPlayedState extends State<SongListMostlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return
        // ValueListenableBuilder(
        //   valueListenable: ,
        //   builder: (context, value, child) {
        //     return GestureDetector(
        //       child:
        GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.mostSongs);
        // Navigator.push(context, MaterialPageRoute(builder: (cntx) {
        //   return CurrentPlayScreen();
        // }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.mostSong.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.mostSong.name,
                style: songNameText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                widget.mostSong.artist,
                style: artistNameText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Wrap(
          spacing: 1,
          children: [
            Text(
              widget.mostSong.count.toString(),
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
                iconSize: 35,
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (!widget.isFavSong) {
                      addFavsongs(widget.mostSong, context);
                      widget.isFavSong = !widget.isFavSong;
                    } else {
                      deleteFavSong(widget.mostSong);
                      widget.isFavSong = !widget.isFavSong;
                    }
                  });
                },
                icon: widget.isFavSong
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.white,
                      )),

            IconButton(
                iconSize: 35,
                color: Colors.white,
                onPressed: () {
                  bottomSheet(context, widget.mostSong);
                },
                icon: Icon(Icons.playlist_add))
            // IconButton(
            //     onPressed: () {},
            //     color: Colors.white,
            //     iconSize: 40,
            //     icon: Icon(Icons.play_circle)),
            // PopupMenuButton(
            //     color: Colors.white,
            //     itemBuilder: (context) => [
            //           PopupMenuItem(
            //               child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text('Add to favourites'),
            //               IconButton(
            //                   onPressed: () {}, icon: Icon(Icons.favorite))
            //             ],
            //           ))
            //         ])
          ],
        ),
      ),
    );
    // );
    // },
    // );
  }

  Future bottomSheet(BuildContext cntx, AllSongsLists song) {
    return showModalBottomSheet(
        context: cntx,
        builder: (BuildContext context) {
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
