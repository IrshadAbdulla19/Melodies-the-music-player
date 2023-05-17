import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';

import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/functions/library_functions/play_list.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongList extends StatefulWidget {
  SongList({super.key});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  late Box<AllSongsLists> allsongBox;
  late Box<PlayListModel> playlistBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allsongBox = Hive.box('allsong');
    playlistBox = Hive.box('playlist_db');
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
                bool isFavSong = isFav(song);
                return AllSongsList(
                  song: song,
                  allSongs: allSongs,
                  index: indx,
                  isFavsong: isFavSong,
                );
              },
              separatorBuilder: (cntx, indx) {
                return Divider();
              },
              itemCount: allSongs.length);
        });
  }
}

class AllSongsList extends StatefulWidget {
  AllSongsList(
      {super.key,
      required this.song,
      required this.allSongs,
      required this.index,
      required this.isFavsong});
  AllSongsLists song;
  List<AllSongsLists> allSongs;
  int index;
  bool isFavsong;
  @override
  State<AllSongsList> createState() => _AllSongsListState();
}

class _AllSongsListState extends State<AllSongsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // playsongs(indx);
        ChangeFormatesong(widget.index, widget.allSongs);

        // Navigator.push(context, MaterialPageRoute(builder: (cntx) {
        //   return CurrentPlayScreen();
        // }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: ListTile(
          tileColor: Color.fromARGB(113, 37, 36, 36),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: QueryArtworkWidget(
              id: widget.song.songID,
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
                  widget.song.name,
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
                  widget.song.artist,
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
                  onPressed: () {
                    setState(() {
                      if (!widget.isFavsong) {
                        addFavsongs(widget.song, context);
                        widget.isFavsong = !widget.isFavsong;
                      } else {
                        deleteFavSong(widget.song);
                        widget.isFavsong = !widget.isFavsong;
                      }
                    });
                  },
                  icon: !widget.isFavsong
                      ? Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
              IconButton(
                  iconSize: 35,
                  color: Colors.white,
                  onPressed: () {
                    bottomSheet(context, widget.song);
                  },
                  icon: Icon(Icons.playlist_add))
              // IconButton(
              //     onPressed: () {
              //       ChangeFormatesong(indx, allSongs);
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
                          // Container(
                          //     color: Colors.grey,
                          //     child: IconButton(
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //         },
                          //         icon: Icon(Icons.keyboard_arrow_down_sharp))),
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
