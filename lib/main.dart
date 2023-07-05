import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/application/ForNav/for_nav_bloc.dart';
import 'package:music_player/application/favourite/favourite_bloc.dart';
import 'package:music_player/application/mostplayed/mostplayed_bloc.dart';
import 'package:music_player/application/playlist/playlist_bloc.dart';
import 'package:music_player/application/resentplayed/resentlyplayed_bloc.dart';
import 'package:music_player/application/search/search_bloc.dart';
import 'package:music_player/infrastructure/db/functions/play_list.dart';
import 'package:music_player/infrastructure/db/songlists_db/playlist/play_list_model.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';
import 'package:music_player/presentation/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userIn = 'for show';
const userCheck = 'for check';
Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AllSongsListsAdapter().typeId)) {
    Hive.registerAdapter(AllSongsListsAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }
  await Hive.openBox<AllSongsLists>('allsong');
  await Hive.openBox<PlayListModel>('playlist_db');

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
  SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForNavBloc(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
        BlocProvider(
          create: (context) => MostplayedBloc(),
        ),
        BlocProvider(
          create: (context) => ResentlyplayedBloc(),
        ),
        BlocProvider(
          create: (context) => PlaylistBloc(),
        ),
        BlocProvider(create: (context) => FavouriteBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: Colors.purple.withOpacity(0.8)),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
