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
            color: Colors.black,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.favorite,
                        text: 'Favourites',
                      ),
                      GButton(
                        icon: Icons.library_music_rounded,
                        text: 'Library',
                      ),
                      GButton(
                        icon: Icons.settings,
                        text: 'Settings',
                      ),
                    ])),
          ),
        ],
      ),
    );
  }
}
