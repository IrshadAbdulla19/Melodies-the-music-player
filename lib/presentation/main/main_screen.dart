import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:music_player/application/ForNav/for_nav_bloc.dart';
import 'package:music_player/functions/home_screen/home_function.dart';
import 'package:music_player/presentation/favourite/favourites_screen.dart';
import 'package:music_player/presentation/home/home_screen.dart';
import 'package:music_player/presentation/library/library_screen.dart';
import 'package:music_player/presentation/settings/settings_screen.dart';
import 'package:music_player/presentation/home/widgets/mini_player.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key, required this.name});
  String name;

  final screens = [
    HomeScreem(),
    const FavoutieScreen(),
    const LibraryScreen(),
    const SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForNavBloc, ForNavState>(
      builder: (context, state) {
        int _currentScreen = state.index;
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: GNav(
                      activeColor: Colors.white,
                      backgroundColor: Colors.black,
                      color: Colors.white,
                      tabBackgroundColor: const Color.fromARGB(255, 77, 70, 70),
                      onTabChange: (index) {
                        context
                            .read<ForNavBloc>()
                            .add(ForNavigation(index: index));
                      },
                      tabs: [
                        gNavButton(Icons.home, 'Home'),
                        gNavButton(Icons.favorite, 'Favourite'),
                        gNavButton(Icons.library_music_rounded, 'Library'),
                        gNavButton(Icons.settings, 'Settings'),
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  GButton gNavButton(IconData icon, String text) {
    return GButton(
      padding: const EdgeInsets.all(15),
      icon: icon,
      text: text,
    );
  }
}
