import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/application/playlist/playlist_bloc.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';

import 'package:music_player/infrastructure/db/songlists_db/playlist/play_list_model.dart';

import 'package:music_player/presentation/library/widgets/playlist/playlist_edit.dart';
import 'package:music_player/presentation/library/widgets/playlist/playlist_screen.dart';

final playlistNames = ['melodies', 'sleeping pills', 'work out', 'personal'];

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        var playlistList = state.thisPlaylist;
        return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: playlistList.length,
            itemBuilder: (cntx, indx) {
              return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (cntx) {
                      var playlist = playlistList[indx];
                      return PlayListScreen(
                        playlist: playlist,
                        index: indx,
                      );
                    }));
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(40.0), //<-- SEE HERE
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: const DecorationImage(
                                image: AssetImage('asset/images/bk1.jpg'),
                                fit: BoxFit.cover)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: _mediaQuary.size.width * 0.3,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'asset/images/bk1.jpg'),
                                                fit: BoxFit.cover)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                playlistList[indx].name,
                                                style: songNameText,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Playlist . ${playlistList[indx].songs?.length ?? 0} songs',
                                                style: songNameText,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  PopupMenuButton(
                                      color: Colors.white,
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Delete Playlist'),
                                                IconButton(
                                                    onPressed: () {
                                                      deletePlaylist(indx,
                                                          playlistList[indx]);
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(Icons.delete)),
                                              ],
                                            )),
                                            PopupMenuItem(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Change name'),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder: (cntx) {
                                                        return PlaylistRename(
                                                          index: indx,
                                                          playlistItem:
                                                              playlistList[
                                                                  indx],
                                                        );
                                                      }));
                                                    },
                                                    icon: Icon(Icons.edit))
                                              ],
                                            ))
                                          ])
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
            });
      },
    );
  }
}
