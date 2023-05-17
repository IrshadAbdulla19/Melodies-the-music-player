import 'package:flutter/material.dart';
import 'package:music_player/db/functions/favourites_funt.dart';
import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/functions/most_played.dart';
import 'package:music_player/db/functions/play_list.dart';
import 'package:music_player/db/functions/resent_played_db.dart';
import 'package:music_player/main.dart';
import 'package:music_player/screens/main_screen.dart';
import 'package:music_player/screens/starting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: Image.asset(
          'asset/images/logo_black.png',
          width: 300,
          height: 430,
        ),
      )),
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
        return MainScreen(name: userIn);
      }));
    }
  }
}
