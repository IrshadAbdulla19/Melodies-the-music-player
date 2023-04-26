import 'package:flutter/material.dart';
import 'package:music_player/screens/current_play_screen.dart';

import 'package:music_player/widgets/home_screen_widg/song_list.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';

class ResentlyPlayed extends StatelessWidget {
  const ResentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: Text(
              'Resently Played',
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
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (cntx, indx) {
                    return SongListResentlyPlayed();
                  }))
        ],
      ),
    );
  }
}

class SongListResentlyPlayed extends StatelessWidget {
  const SongListResentlyPlayed({super.key});

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
          'Resently played song name',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'singers name',
          style: TextStyle(color: Colors.white),
        ),
        trailing: Wrap(
          spacing: 1,
          children: [
            IconButton(
                onPressed: () {},
                color: Colors.white,
                iconSize: 40,
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
                          Text('Add to favourites'),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.favorite))
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
