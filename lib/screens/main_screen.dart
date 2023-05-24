import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_player/functions/home_screen/home_function.dart';

import 'package:music_player/screens/favourites_screen.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/screens/library_screen.dart';
import 'package:music_player/screens/settings_screen.dart';
import 'package:music_player/widgets/home_screen_widg/mini_player.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.name});
  String name;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;
  final screens = [
    HomeScreem(),
    FavoutieScreen(),
    LibraryScreen(),
    SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[_currentScreen],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ValueListenableBuilder(
              valueListenable: isSongPlayingNotifier,
              builder: (BuildContext contx, isPlay, Widget? child) {
                return isPlay ? const MiniPlayer() : const SizedBox();
              }),
          Container(
            width: double.infinity,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: GNav(
                  activeColor: Colors.white,
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  tabBackgroundColor: Color.fromARGB(255, 77, 70, 70),
                  onTabChange: (index) {
                    setState(() {
                      _currentScreen = index;
                    });
                  },
                  tabs: [
                    GButton(
                      padding: EdgeInsets.all(15),
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      padding: EdgeInsets.all(15),
                      icon: Icons.favorite,
                      text: 'Favourite',
                    ),
                    GButton(
                      padding: EdgeInsets.all(15),
                      icon: Icons.library_music_rounded,
                      text: 'Library',
                    ),
                    GButton(
                      padding: EdgeInsets.all(15),
                      icon: Icons.settings,
                      text: 'Settings',
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
