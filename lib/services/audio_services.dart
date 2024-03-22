import 'package:audioplayers/audioplayers.dart';
import 'package:logger/logger.dart';

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

final player = AudioPlayer();
void makeNoise(int index) async {
  try {
    // await player.stop();
    final sourceFile = audioAssets[index]!;
    await player.play(AssetSource(sourceFile));
  } catch (e) {
    final logger = Logger();
    logger.e('Error playing audio index: $index', e);
  }
}

//Ensures audio files are cached to audio player before game starts.
Future<void> loadAllAudioSources() async {
  for (var audioFile in audioAssets.values) {
    await _loadSource(audioFile);
  }
}

Future<void> _loadSource(String audioFilePath) async {
  await player.setSource(AssetSource(audioFilePath));
  await player.release();
}
