import 'package:flutter/material.dart';
import 'package:music_player/functions/settings_function/for_fetch_songs.dart';
import 'package:music_player/infrastructure/db/functions/favourites_funt.dart';
import 'package:music_player/infrastructure/db/functions/functions.dart';
import 'package:music_player/infrastructure/db/functions/most_played.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/functions/resent_played_db.dart';
import 'package:music_player/main.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:music_player/presentation/main/main_screen.dart';
import 'package:music_player/presentation/user/starting_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkpermission();
    cheakUserIn();
    getAllSongs();
    getFavSongs();
    getMostPlayed();
    getResentPlyed();
    getPlaylist();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: SafeArea(
          child: Center(
            child: Wrap(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'asset/images/logo_black.png',
                      alignment: Alignment.center,
                      scale: _mediaQuary.size.width * 0.002,
                    ),
                  ],
                ),
                splashTexts("Melodiues", mainHead),
                splashTexts("Let's connect to the music♪ ", splashMini),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row splashTexts(String text, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ],
    );
  }

  Future<void> forNavigation() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (cntx) {
      return StartingPage();
    }));
  }

  Future<void> cheakUserIn() async {
    final sharepref = await SharedPreferences.getInstance();
    final UserCheack = sharepref.getBool(userCheck);
    if (UserCheack == null || UserCheack == false) {
      forNavigation();
    } else {
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (cntx) {
        return MainScreen(name: "main");
      }));
    }
  }
}
