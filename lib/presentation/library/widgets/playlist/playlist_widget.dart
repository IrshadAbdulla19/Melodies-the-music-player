import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';
import 'package:music_player/application/playlist/playlist_bloc.dart';
import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/library/widgets/playlist/add_new_playlist.dart';

class PlayListShowWidget extends StatefulWidget {
  MediaQueryData mediaQuary;
  AllSongsLists song;
  PlayListShowWidget({super.key, required this.mediaQuary, required this.song});

  @override
  State<PlayListShowWidget> createState() => _PlayListShowWidgetState();
}

class _PlayListShowWidgetState extends State<PlayListShowWidget> {
  @override
  Widget build(BuildContext context) {
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
                      height: widget.mediaQuary.size.height * 0.06,
                      width: widget.mediaQuary.size.width * 0.5,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (cntx1) {
                              return PlaylistAdd();
                            }));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 6, 59, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
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
                      child: BlocBuilder<PlaylistBloc, PlaylistState>(
                        builder: (context, state) {
                          var playlistList = state.thisPlaylist;
                          return ListView.builder(
                              itemCount: playlistList.length,
                              itemBuilder: (cntx, indx) {
                                var playlist = playlistList[indx];
                                bool isInPlaylist =
                                    checkPlaylist(widget.song, indx);
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
                                                  context
                                                      .read<PlaylistBloc>()
                                                      .add(PlaylistSongAddEvent(
                                                          playlist: playlist,
                                                          song: widget.song));
                                                  isInPlaylist = !isInPlaylist;
                                                } else {
                                                  removeSongFromDB(widget.song,
                                                      playlist, indx);
                                                  isInPlaylist = !isInPlaylist;
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
  }
}
