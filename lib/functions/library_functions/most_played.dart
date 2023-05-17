import 'package:music_player/db/functions/functions.dart';
import 'package:music_player/db/functions/most_played.dart';
import 'package:music_player/db/songlists_db/songlist.dart';

List<AllSongsLists> mostPlayedList = [];
// List<AllSongsLists> mostPlaySortList = [];

Future<void> mostPlayAdd(int songID) async {
  for (var element in AllSongsNotifier.value) {
    if (element.songID == songID) {
      // if (mostPlayedList.contains(element)) {
      //   for (var mostPlayEle in mostPlayedList) {
      //     // print(mostPlayEle.name);
      //     if (mostPlayEle.songID == songID) {
      //       mostPlayEle.count = mostPlayEle.count! + 1;
      //     }
      //   }
      // } else {
      //   element.count = 1;
      //   mostPlayedList.add(element);
      // }
      mostPlayedList.insert(0, element);
      addMostPlayedList(mostPlayedList[0]);
    }
  }
  // AllSongsLists temp;
  // for (var i = 0; i < mostPlayedList.length; i++) {
  //   for (var j = i + 1; j < mostPlayedList.length; j++) {
  //     if (mostPlayedList[i].count! < mostPlayedList[j].count!) {
  //       temp = mostPlayedList[i];
  //       mostPlayedList[i] = mostPlayedList[j];
  //       mostPlayedList[j] = temp;
  //     }
  //   }
  // }
}
