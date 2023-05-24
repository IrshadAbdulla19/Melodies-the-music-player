import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/functions/resent_played_db.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';

import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/library_screen/playlist/add_new_playlist.dart';
import 'package:music_player/widgets/library_screen/playlist/ful_resent_play.dart';

import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ResentlyPlayed extends StatefulWidget {
  const ResentlyPlayed({super.key});

  @override
  State<ResentlyPlayed> createState() => _ResentlyPlayedState();
}

class _ResentlyPlayedState extends State<ResentlyPlayed> {
  late Box<AllSongsLists> resentBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    resentBox = Hive.box('resent_db');
  }

  @override
  Widget build(BuildContext context) {
    return
        // Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: Row(
        //     children: [
        //       // Expanded(
        //       //     flex: 4,
        //       //     child: TextFormField(
        //       //       style: TextStyle(color: Colors.white),
        //       //       decoration: InputDecoration(
        //       //           filled: true,
        //       //           fillColor: const Color.fromARGB(255, 6, 59, 102),
        //       //           contentPadding: const EdgeInsets.symmetric(
        //       //               vertical: 10, horizontal: 10),
        //       //           border: OutlineInputBorder(
        //       //               borderRadius: BorderRadius.circular(28))),
        //       //     )),
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
      valueListenable: resentPlyedNotifier,
      builder:
          (BuildContext cntx, List<AllSongsLists> resentSongs, Widget? child) {
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: resentSongs.length,
            itemBuilder: (cntx, indx) {
              var song = resentSongs[indx];
              bool isFavSong = isFav(song);
              return SongListResentlyPlayed(
                isFavSong: isFavSong,
                index: indx,
                resentSongs: resentSongs,
                song: song,
              );
            });
      },
    );
  }
}

class SongListResentlyPlayed extends StatefulWidget {
  SongListResentlyPlayed(
      {super.key,
      required this.song,
      required this.index,
      required this.resentSongs,
      required this.isFavSong});
  AllSongsLists song;
  int index;
  List<AllSongsLists> resentSongs;
  bool isFavSong;

  @override
  State<SongListResentlyPlayed> createState() => _SongListResentlyPlayedState();
}

class _SongListResentlyPlayedState extends State<SongListResentlyPlayed> {
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
        ChangeFormatesong(widget.index, widget.resentSongs);
        // Navigator.push(context, MaterialPageRoute(builder: (cntx) {
        //   return CurrentPlayScreen();
        // }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.song.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.song.name,
                style: songNameText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(widget.song.artist,
                  style: artistNameText, overflow: TextOverflow.ellipsis),
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
                    if (!widget.isFavSong) {
                      addFavsongs(widget.song, context);
                      widget.isFavSong = !widget.isFavSong;
                    } else {
                      deleteFavSong(widget.song);
                      widget.isFavSong = !widget.isFavSong;
                    }
                  });
                },
                icon: !widget.isFavSong
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
