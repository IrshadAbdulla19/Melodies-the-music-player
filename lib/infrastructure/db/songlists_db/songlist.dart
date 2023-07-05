import 'package:hive_flutter/adapters.dart';
part 'songlist.g.dart';

@HiveType(typeId: 0)
class AllSongsLists {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String artist;

  @HiveField(3)
  String uri;

  @HiveField(4)
  int songID;

  @HiveField(5)
  int duration;

  @HiveField(6)
  int? count;

  AllSongsLists(
      {required this.name,
      required this.artist,
      required this.uri,
      required this.songID,
      required this.duration,
      this.count,
      this.id});
}

// String boxname = 'allsong';

// class SongBox {
//   static Box<AllSongsLists>? _box;
//   static Box<AllSongsLists> getInstance() {
//     return _box ??= Hive.box(boxname);
//   }
// }
