import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/screens/current_play_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (cntx) {
            return CurrentPlayScreen();
          }));
        },
        child: Card(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('asset/images/537fb671eab8eae744d3ee96.webp'),
                  fit: BoxFit.cover)),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      width: 110,
                      height: 120,
                      child: Image.asset(
                          'asset/images/537fb671eab8eae744d3ee96.webp'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'song name',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          Column(
                            children: [
                              Slider(
                                  activeColor: Colors.blue,
                                  inactiveColor: Colors.grey,
                                  min: 0.0,
                                  value: 2,
                                  max: 2,
                                  onChanged: (value) {}),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      iconSize: 35,
                                      icon: Icon(Icons.skip_previous_rounded)),
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      iconSize: 35,
                                      icon: Icon(Icons.play_circle)),
                                  IconButton(
                                      onPressed: () {},
                                      color: Colors.white,
                                      iconSize: 35,
                                      icon: Icon(Icons.skip_next_rounded)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
