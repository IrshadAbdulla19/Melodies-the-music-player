import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_player/widgets/home_screen_widg/mini_player.dart';

import 'package:music_player/widgets/home_screen_widg/song_list.dart';
import 'package:music_player/widgets/home_screen_widg/top_part.dart';

class HomeScreem extends StatefulWidget {
  const HomeScreem({
    super.key,
  });

  @override
  State<HomeScreem> createState() => _HomeScreemState();
}

class _HomeScreemState extends State<HomeScreem> {
  @override
  void initState() {
    TopPart();
    super.initState();
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
                    TopPart(),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        'All songs',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                    ),
                    Expanded(flex: 5, child: SongList()),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: MiniPlayer(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
