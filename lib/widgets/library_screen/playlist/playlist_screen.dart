import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/styles/style.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayListScreen extends StatefulWidget {
  PlayListScreen({super.key, required this.playlist, required this.index});
  PlayListModel playlist;
  int index;

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  late Box<PlayListModel> playlistBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistBox = Hive.box('playlist_db');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.keyboard_arrow_down_sharp))),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, bottom: 10),
                          child: Text(
                            widget.playlist.name,
                            style: mainHead,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 6, 59, 102),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(28))),
                                  )),
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.search)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ValueListenableBuilder(
                            valueListenable: PlaylistNotifer,
                            builder: (BuildContext context,
                                List<PlayListModel> playlistList,
                                Widget? child) {
                              return ListView.separated(
                                  itemBuilder: (cntx, indx) {
                                    var song =
                                        playlistList[widget.index].songs?[indx];
                                    bool isFavSong = isFav(song);
                                    return SongListPlaylist(
                                      isFavsong: isFavSong,
                                      index: indx,
                                      allsongs:
                                          playlistList[widget.index].songs,
                                      song: song,
                                      item: widget.playlist,
                                      playlistIndex: widget.index,
                                    );
                                  },
                                  separatorBuilder: (cntx, indx) {
                                    return Divider();
                                  },
                                  itemCount:
                                      widget.playlist.songs?.length ?? 0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}

class SongListPlaylist extends StatefulWidget {
  SongListPlaylist(
      {super.key,
      required this.song,
      required this.item,
      required this.allsongs,
      required this.index,
      required this.isFavsong,
      required this.playlistIndex});
  AllSongsLists? song;
  PlayListModel item;
  bool isFavsong;
  int index;
  List<AllSongsLists>? allsongs;
  int playlistIndex;

  @override
  State<SongListPlaylist> createState() => _SongListPlaylistState();
}

class _SongListPlaylistState extends State<SongListPlaylist> {
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
        ChangeFormatesong(widget.index, widget.allsongs);
        Navigator.push(context, MaterialPageRoute(builder: (cntx) {
          return CurrentPlayScreen(
            song: widget.song!,
          );
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 30,
          child: QueryArtworkWidget(
            id: widget.song!.songID,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Icon(Icons.music_note),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                widget.song?.name ?? 'song name',
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
                widget.song?.artist ?? 'artits',
                style: artistNameText,
                overflow: TextOverflow.ellipsis,
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
                      widget.isFavsong = isFav(widget.song);
                    } else {
                      deleteFavSong(widget.song);
                      widget.isFavsong = isFav(widget.song);
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
                onPressed: () {
                  removeSongFromDB(
                      widget.song, widget.item, widget.playlistIndex);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                )),
            // PopupMenuButton(
            //     color: Colors.white,
            //     itemBuilder: (context) => [
            //           PopupMenuItem(
            //               child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text('Remove from Playlist'),
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
}
