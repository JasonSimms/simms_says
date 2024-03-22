// import 'package:flame_audio/flame_audio.dart';
import 'package:logger/logger.dart';
import 'package:audioplayers/audioplayers.dart';

final logger = Logger();

/*
* assets:
    - assets/audio/bell_ring_001_73093.mp3
    - assets/audio/bell_small_001.mp3
    - assets/audio/bell_small_002.mp3
    - assets/audio/bell_large_ring_designed.mp3
    - assets/audio/bell_med_large_ring_designed.mp3
    - assets/audio/cartoon_fall_fast_whistling.mp3
*/

final audioAssets = {
  1: 'audio/bell_ring_001_73093.mp3', //BUTTONS
  2: 'audio/bell_small_001.mp3',
  3: 'audio/bell_small_002.mp3',
  4: 'audio/bell_large_ring_designed.mp3',
  5: 'audio/bell_med_large_ring_designed.mp3',
  99: 'audio/cartoon_fall_fast_whistling.mp3', //GAMEOVER
};
String getAudioAsset(int key) => audioAssets[key] ?? 'audio/bell_small_001.mp3';

final player = AudioPlayer();
void makeNoise(int index) async {
  try {
    final String sourceFile = getAudioAsset(index);
    await player.play(AssetSource(sourceFile));
    player.onPlayerComplete.listen((event) {
      player.stop();
    });
  } catch (e) {
    logger.e('Problem makeNoise', error: e);
  }
}

//Ensures audio files are cached to audio player before game starts.
Future<void> loadAllAudioSources() async {
  final assetList = audioAssets.values.toList();
  assetList.map((el) => {_loadSource(el)});
  return;
}

Future<void> _loadSource(String audioFilePath) async {
  try {
    await player.setSource(AssetSource(audioFilePath));
    await player.release();
  } catch (e) {
    final logger = Logger();
    logger.e('Error _loadSource: $audioFilePath', error: e);
  }
}
