import 'package:shared_preferences/shared_preferences.dart';
import "package:logger/logger.dart";

// Create a logger instance
final logger = Logger();
int _highScore = 0;

Future<int> registerScore(int score) async {
  logger.d('finished a game lets register that score $score');
  try {
    if (score > 0 && _highScore == 0) {
      _highScore = score;
      await saveHighScore(score);
      return score;
    }
    if (score > 0 && _highScore > 0) {
      if (score > _highScore) {
        logger.d('new high score! $score');
        _highScore = score;
        await saveHighScore(score);
      } else {
        return _highScore;
      }
    }
    return score;
  } catch (e, stackTrace) {
    logger.e('An error occurred', error: e, stackTrace: stackTrace);
    return score;
  }
}

// To save data
Future<void> saveHighScore(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('highScore', value);
}

// To read data
Future<int?> readHighScore() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? data = prefs.getInt('highScore');
    return data ?? 0;
  } catch (e) {
    logger.e('error reading highScore', error: e);
    return 0;
  }
}
