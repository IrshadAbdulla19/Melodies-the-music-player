import 'package:hive_flutter/adapters.dart';
import 'package:music_player/db/songlists_db/favourites/play_list_model.dart';

Future<void> addDatabase(PlayListModel item) async {
  final playlistDB = await Hive.openBox<PlayListModel>('playlist_db');
  String name = item.name;
  bool check = false;
  for (var element in playlistDB.values) {
    if (element.name == name) {
      check = true;
      break;
    }
  }
  if (check == false) {
    final _id = playlistDB.add(item);
  }
}
