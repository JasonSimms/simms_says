import 'package:flutter/material.dart';
import 'package:simms_says/models/game_state.dart';
import 'package:logger/logger.dart';
import 'package:simms_says/services/animation_services.dart';
import 'package:simms_says/services/game_services.dart';
import 'package:simms_says/services/audio_services.dart';
import 'package:simms_says/services/score_services.dart';

class GameStateProvider with ChangeNotifier {
  final logger = Logger();
  final AnimationService _animationService = AnimationService();
  final GameService _gameService = GameService();
  final GameState _gameState = GameState();

  int _currentUserIndex = 0;

  // Getter to access the game state
  GameState get gameState => _gameState;

  // User presses buttons in order they were presented from buttonSequence
  void checkInput(int value) async {
    makeNoise(value);

    if (gameState.buttonSequence.isEmpty || gameState.isBusy) {
      return; //Game is not started or is animating
    }

    //Validate correct or incorrect
    bool isValid = value == gameState.buttonSequence[_currentUserIndex];
    // Input is correct and reached the end of sequence
    if (isValid && _currentUserIndex == gameState.buttonSequence.length - 1) {
      _currentUserIndex = 0; // Game expects the user to start over.
      _nextLevel();
      startAnimation();
    }
    // Input is valid but there are more to go in the sequence.
    else if (isValid) {
      _currentUserIndex++;
    } else {
      //Lose scenario
      makeNoise(99);
      _gameState.highScore =
          await registerScore(gameState.buttonSequence.length - 1);
      _reset();
    }
  }

  void startNewGame() {
    _reset();
    _nextLevel();
    gameState.isGameOn = true;
    notifyListeners();
    startAnimation();
  }

  void _reset() {
    gameState.buttonSequence = [];
    gameState.animatedButton = 0;
    gameState.isGameOn = false;
    _currentUserIndex = 0;
    notifyListeners();
  }

  void _nextLevel() {
    _gameService.nextLevel(_gameState.buttonSequence, notifyListeners);
  }

  //Animate the button sequence
  Future<void> startAnimation() async {
    updateIsBusy(true);
    await _animationService.startAnimation(
        _gameState.buttonSequence, updateAnimatedButton, makeNoise);
    updateIsBusy(false);
  }

  void setLoading(bool val) {
    _gameState.isLoading = val;
    notifyListeners();
  }

  void loadAssets() async {
    logger.d('load them assets..');
    try {
      await loadAllAudioSources();
      _gameState.highScore =
          (await readHighScore())!; //Set highscore from local storage
    } catch (e) {
      logger.e('Error loading assets....', error: e);
    }
    logger.d('loaded assets?');
    setLoading(false);
  }

  void updateIsBusy(bool val) {
    _gameState.isBusy = val;
    notifyListeners();
  }

  void updateAnimatedButton(int index) {
    _gameState.animatedButton = index;
    notifyListeners();
  }
}
