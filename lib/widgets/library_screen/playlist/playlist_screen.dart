import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/screens/current_play_screen.dart';

class PlayListScreen extends StatelessWidget {
  PlayListScreen({super.key, required this.playlistName});
  String playlistName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
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
                            playlistName,
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
                          child: ListView.separated(
                              itemBuilder: (cntx, indx) {
                                return SongListPlaylist();
                              },
                              separatorBuilder: (cntx, indx) {
                                return Divider();
                              },
                              itemCount: 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
    ;
  }
}

class SongListPlaylist extends StatelessWidget {
  const SongListPlaylist({super.key});

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
          'Playlist songs',
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
                          Text('Remove from Playlist'),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete)),
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
}
