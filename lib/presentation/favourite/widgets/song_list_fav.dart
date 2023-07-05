import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';

import 'package:music_player/functions/home_screen/home_function.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';

import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/library/widgets/playlist/add_new_playlist.dart';

import 'package:on_audio_query/on_audio_query.dart';

class SongListFavourite extends StatefulWidget {
  SongListFavourite(
      {super.key,
      required this.song,
      required this.index,
      required this.favSongs});
  AllSongsLists song;
  List<AllSongsLists> favSongs;
  int index;

  @override
  State<SongListFavourite> createState() => _SongListFavouriteState();
}

class _SongListFavouriteState extends State<SongListFavourite> {
  // Future<bool> checkFav = isFav(widget.song);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ChangeFormatesong(widget.index, widget.favSongs);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 30,
            child: QueryArtworkWidget(
              id: widget.song.songID,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: const Icon(Icons.music_note),
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
                child: Text(
                  widget.song.artist,
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
                    context
                        .read<FavouriteBloc>()
                        .add(FavoutieDeleteEvent(favSong: widget.song));
                  },
                  icon: Icon(
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
            ],
          ),
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
                              builder: (BuildContext context, playlistList,
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
