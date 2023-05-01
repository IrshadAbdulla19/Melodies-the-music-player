import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/play_controller.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/screens/current_play_screen.dart';
import 'package:music_player/widgets/home_screen_widg/song_list.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';

class SongListFavourite extends StatelessWidget {
  SongListFavourite({
    super.key,
  });

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
        Navigator.push(context, MaterialPageRoute(builder: (cntx) {
          return CurrentPlayScreen();
        }));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              AssetImage('asset/images/537fb671eab8eae744d3ee96.webp'),
          radius: 30,
        ),
        title: Text(
          'favSongname',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'favSongartist',
          style: TextStyle(color: Colors.white),
        ),
        trailing: Wrap(
          spacing: 1,
          children: [
            IconButton(
                onPressed: () {},
                iconSize: 40,
                color: Colors.white,
                icon: Icon(Icons.play_circle)),
            PopupMenuButton(
                color: Colors.white,
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Add Playlist'),
                          IconButton(
                              onPressed: () {
                                bottomSheet(context);
                              },
                              icon: Icon(Icons.playlist_add)),
                        ],
                      )),
                      PopupMenuItem(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Remove from favourites'),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.heart_broken_rounded))
                        ],
                      ))
                    ])
          ],
        ),
      ),
    );
    // );
    // },
    // );
  }

  Future bottomSheet(BuildContext cntx) {
    return showModalBottomSheet(
        context: cntx,
        builder: (BuildContext context) {
          return SizedBox(
              height: 400,
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
                    child: ListView.builder(
                        itemCount: playlistNames.length,
                        itemBuilder: (cntx, indx) {
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(playlistNames[indx]),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.add_circle))
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ));
        });
  }
}
