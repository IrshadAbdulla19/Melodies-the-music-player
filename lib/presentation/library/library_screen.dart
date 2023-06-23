import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/domain/core/style.dart';

import 'package:music_player/presentation/library/widgets/mostly_played.dart';
import 'package:music_player/presentation/library/widgets/playlist/add_new_playlist.dart';
import 'package:music_player/presentation/library/widgets/playlist/playlist.dart';
import 'package:music_player/presentation/library/widgets/resently_played.dart';

int currentList = 0;
final screenName = ['Resently Played', 'Mostly Played', 'Playlist'];
final screens = [ResentlyPlayed(), MostlyPlayed(), PlayList()];

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/images/images (1).jpeg'),
              fit: BoxFit.cover)),
      child: ClipRRect(
          child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Scaffold(
          // extendBody: true,
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,

          body: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'Library',
                        style: mainHead,
                      ),
                    ),
                    SizedBox(
                        height: 300,
                        child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (cntx, indx) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    currentList = indx;
                                  });
                                },
                                child: Container(
                                  width: 250,
                                  height: 100,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'asset/images/bk$indx.jpg'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      screenName[indx],
                                      style: mainHead,
                                    ),
                                  ),
                                ),
                              );
                            })),
                    Flexible(
                        child: Text(
                      screenName[currentList],
                      style: mainHead,
                    )),
                    currentList == 2 ? ForPlayList() : ForOther(),
                    Flexible(child: screens[currentList])
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class ForPlayList extends StatefulWidget {
  const ForPlayList({
    super.key,
  });

  @override
  State<ForPlayList> createState() => _ForPlayListState();
}

class _ForPlayListState extends State<ForPlayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (cntx1) {
              return PlaylistAdd();
            }));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 14, 65, 107),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Create Playlist",
                style: TextStyle(fontSize: 17),
              ),
              Icon(
                Icons.add,
                size: 15,
              )
            ],
          )),
    );
  }
}

class ForOther extends StatelessWidget {
  const ForOther({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      width: 10,
    );
  }
}
