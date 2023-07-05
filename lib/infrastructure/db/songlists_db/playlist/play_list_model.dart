import 'package:hive_flutter/adapters.dart';
import 'package:music_player/infrastructure/db/songlists_db/songlist.dart';

part 'play_list_model.g.dart';

@HiveType(typeId: 1)
class PlayListModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<AllSongsLists>? songs;

  PlayListModel({required this.name, this.songs, this.id});
}

// String boxnamefav = 'favourites';

// class SongBox {
//   static Box<FavouriteSongsModel>? _box;
//   static Box<FavouriteSongsModel> getInstance() {
//     return _box ??= Hive.box(boxnamefav);
//   }
// }
