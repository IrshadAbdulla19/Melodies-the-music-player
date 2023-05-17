import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/styles/style.dart';

class ResentPlayFullScreen extends StatefulWidget {
  const ResentPlayFullScreen({super.key});

  @override
  State<ResentPlayFullScreen> createState() => _ResentPlayFullScreenState();
}

class _ResentPlayFullScreenState extends State<ResentPlayFullScreen> {
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
                            child:
                                // ValueListenableBuilder(
                                //   valueListenable: FavSongsNotifier,
                                //   builder: (BuildContext cntx,
                                //       List<AllSongsLists> favSongs, Widget? child) {
                                //     return favSongs.length == 0
                                //         ? Center(
                                //             child: Text(
                                //               'No songs',
                                //               style: mainHead,
                                //             ),
                                //           )
                                //         :
                                ListView.separated(
                                    itemBuilder: (cntx, indx) {
                                      // var song = favSongs[indx];
                                      return ListTile(
                                        title: Text('hi'),
                                      );
                                      // SongListFavourite(
                                      //   favSongs: favSongs,
                                      //   song: song,
                                      //   index: indx,
                                      // );
                                    },
                                    separatorBuilder: (cntx, indx) {
                                      return Divider();
                                    },
                                    itemCount: 8)
                            // },
                            )
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
    ;
  }
}
