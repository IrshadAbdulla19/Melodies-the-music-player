import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';

import 'package:music_player/domain/core/style.dart';

import 'package:music_player/presentation/library/widgets/playlist/playlist_edit.dart';
import 'package:music_player/presentation/library/widgets/playlist/playlist_screen.dart';

final playlistNames = ['melodies', 'sleeping pills', 'work out', 'personal'];

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return
        // Padding(
        //   padding: const EdgeInsets.only(left: 10, top: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Padding(
        //         padding: const EdgeInsets.only(left: 15.0, bottom: 10),
        //         child: Text(
        //           'Playlist',
        //           style: mainHead,
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.only(left: 10.0),
        //         child: Row(
        //           children: [
        //             Expanded(
        //               flex: 1,
        //               child: CircleAvatar(
        //                 child: IconButton(
        //                     onPressed: () {
        //                       Navigator.push(context,
        //                           MaterialPageRoute(builder: (cntx) {
        //                         return PlaylistAdd();
        //                       }));
        //                     },
        //                     icon: Icon(Icons.playlist_add)),
        //               ),
        //             ),
        //             Expanded(
        //                 flex: 4,
        //                 child: TextFormField(
        //                   style: TextStyle(color: Colors.white),
        //                   decoration: InputDecoration(
        //                       filled: true,
        //                       fillColor: Color.fromARGB(255, 6, 59, 102),
        //                       contentPadding: const EdgeInsets.symmetric(
        //                           vertical: 10, horizontal: 10),
        //                       border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(28))),
        //                 )),
        //             Expanded(
        //               flex: 1,
        //               child: CircleAvatar(
        //                 child:
        //                     IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),

        ValueListenableBuilder(
      valueListenable: PlaylistNotifer,
      builder:
          (BuildContext cntx, List<PlayListModel> playlistList, Widget? child) {
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
                        // side: BorderSide(
                        //   color: Colors.greenAccent,
                        // ),
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
