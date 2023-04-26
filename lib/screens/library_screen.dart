import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:music_player/widgets/library_screen/mostly_played.dart';
import 'package:music_player/widgets/library_screen/playlist/playlist.dart';
import 'package:music_player/widgets/library_screen/resently_played.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final screenName = ['Resently Played', 'Mostly Played', 'Playlist'];
  int _currentList = 0;
  final screens = [ResentlyPlayed(), MostlyPlayed(), PlayList()];
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'Library',
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontFamily: 'Dongle',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (cntx, indx) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _currentList = indx;
                                    });
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 100,
                                    margin: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        screenName[indx],
                                        style: TextStyle(
                                            fontSize: 55,
                                            color: Colors.white,
                                            fontFamily: 'Dongle',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'asset/images/bk$indx.jpg'),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                );
                                ;
                              }),
                        ),
                        Flexible(child: screens[_currentList])
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
