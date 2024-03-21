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

void makeNoise(int index) async {
  String sourceFile;

  switch (index) {
    case 1:
      sourceFile = '/audio/bell_small_001.mp3';
    case 2:
      sourceFile = '/audio/bell_ring_001_73093.mp3';
    case 3:
      sourceFile = '/audio/bell_small_002.mp3';
    case 4:
      sourceFile = '/audio/bell_large_ring_designed.mp3';
    case 5:
      sourceFile = '/audio/bell_large_ring_designed.mp3';
    case 99: //Game Over
      sourceFile = '/audio/cartoon_fall_fast_whistling.mp3';
    default:
      sourceFile = '/audio/bell_large_ring_designed.mp3';
  }
  try {
    final player = AudioPlayer();
    await player.play(AssetSource(sourceFile));
  } catch (e) {
    final logger = Logger();
    logger.e('Error playing audio index: $index', e);
  }
}
