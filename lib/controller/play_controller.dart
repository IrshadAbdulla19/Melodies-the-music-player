import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayController extends GetxController {
  final audioquray = OnAudioQuery();
  final audioplayer = AudioPlayer();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkPermission();
  }

  playSong(String? uri) {
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var permis = await Permission.storage.request();
    if (permis.isGranted) {
    } else {
      checkPermission();
    }
  }
}
