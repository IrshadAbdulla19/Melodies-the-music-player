import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/widgets/library_screen/playlist/add_new_playlist.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist_edit.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist_screen.dart';

final playlistNames = ['melodies', 'sleeping pills', 'work out', 'personal'];

class PlayList extends StatefulWidget {
  const PlayList({super.key});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 10),
            child: Text(
              'Playlist',
              style: TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                  fontFamily: 'Dongle',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (cntx) {
                            return PlaylistAdd();
                          }));
                        },
                        icon: Icon(Icons.playlist_add)),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 6, 59, 102),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28))),
                    )),
                Expanded(
                  flex: 1,
                  child: CircleAvatar(
                    child:
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (cntx, indx) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (cntx) {
                            return PlayListScreen(
                                playlistName: playlistNames[indx]);
                          }));
                        },
                        child: Card(
                            child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(
                                      'asset/images/playlistback.jpg'),
                                  fit: BoxFit.cover)),
                          child: ClipRRect(
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
                                          width: 110,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'asset/images/playlistback.jpg'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  playlistNames[indx],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Playlist . 3 songs',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
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
                                                      onPressed: () {},
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
                                                                builder:
                                                                    (cntx) {
                                                          return PlaylistRename();
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
                    ;
                  }))
        ],
      ),
    );
  }
}
