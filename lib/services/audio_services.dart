import 'package:audioplayers/audioplayers.dart';

void makeNoise(int index) async {
  String sourceFile;

  switch (index) {
    case 1:
      sourceFile = '/audio/bell_small_001.mp3';
    case 2:
      sourceFile = '/audio/bell_small_001.mp3';
    case 3:
    case 4:
    case 5:
    default:
      sourceFile = '/audio/bell_small_002.mp3';
  }
  try {
    print('letsmake noise');
    final player = AudioPlayer();
    await player.play(AssetSource(sourceFile));
  } catch (e) {
    print('woops');
  }
}
