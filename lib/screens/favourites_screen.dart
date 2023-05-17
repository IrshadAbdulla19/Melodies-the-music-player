import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';
import 'package:music_player/db/songlists_db/songlist.dart';
import 'package:music_player/styles/style.dart';

import 'package:music_player/widgets/favourite_screen/song_list_fav.dart';
import 'package:music_player/widgets/favourite_screen/top_part_fav.dart';

class FavoutieScreen extends StatefulWidget {
  const FavoutieScreen({super.key});

  @override
  State<FavoutieScreen> createState() => _FavoutieScreenState();
}

class _FavoutieScreenState extends State<FavoutieScreen> {
  late Box<AllSongsLists> favSongbox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favSongbox = Hive.box('favsongs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        const Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'Favourites',
                            style: mainHead,
                          ),
                        ),
                        // TopPartFavourite(),
                        Expanded(
                            flex: 3,
                            child: ValueListenableBuilder(
                              valueListenable: FavSongsNotifier,
                              builder: (BuildContext cntx,
                                  List<AllSongsLists> favSongs, Widget? child) {
                                return favSongs.length == 0
                                    ? Center(
                                        child: Text(
                                          'No songs',
                                          style: mainHead,
                                        ),
                                      )
                                    : ListView.separated(
                                        itemBuilder: (cntx, indx) {
                                          var song = favSongs[indx];
                                          return SongListFavourite(
                                            favSongs: favSongs,
                                            song: song,
                                            index: indx,
                                          );
                                        },
                                        separatorBuilder: (cntx, indx) {
                                          return Divider();
                                        },
                                        itemCount: favSongs.length);
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
