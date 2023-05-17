import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/functions/resent_played_db.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

List<AllSongsLists> resentPlyedList = [];

Future<void> resentPlyed(int songId) async {
  for (var element in AllSongsNotifier.value) {
    if (songId == element.songID) {
      // if (!resentPlyedList.contains(element)) {
      //   resentPlyedList.insert(0, element);
      //   addResentPlyed(resentPlyedList[0]);
      // } else {
      //   for (var element in resentPlyedList) {
      //     if (songId == element.songID) {
      //       resentPlyedList.remove(element);
      //       resentPlyedList.insert(0, element);
      //       addResentPlyed(resentPlyedList[0]);
      //     }
      //   }
      // }
      resentPlyedList.insert(0, element);
      addResentPlyed(resentPlyedList[0]);
    }
  }
}
