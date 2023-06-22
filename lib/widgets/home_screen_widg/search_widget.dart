import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';

import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/library_screen/playlist/add_new_playlist.dart';

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
              bool isFavSong = isFav(song);
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
                            onPressed: () {
                              setState(() {
                                if (!isFavSong) {
                                  addFavsongs(song, context);
                                  isFavSong = !isFavSong;
                                } else {
                                  deleteFavSong(song);
                                  isFavSong = !isFavSong;
                                }
                              });
                            },
                            icon: !isFavSong
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
                              bottomSheet(context, song);
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
            child: Text(
              'No songa Found',
              style: mainHead,
            ),
          );
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
