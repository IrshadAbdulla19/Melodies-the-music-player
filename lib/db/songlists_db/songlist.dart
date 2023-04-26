import 'package:hive_flutter/adapters.dart';
part 'songlist.g.dart';

@HiveType(typeId: 1)
class SongsLists {
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

  SongsLists(
      {required this.name,
      required this.artist,
      required this.uri,
      required this.songID,
      this.id});
}
