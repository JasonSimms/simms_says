import 'package:flutter/material.dart';
import 'package:simms_says/models/game_state.dart';
import 'package:logger/logger.dart';
import 'package:simms_says/services/animation_services.dart';
import 'package:simms_says/services/game_services.dart';
import 'package:simms_says/services/audio_services.dart';

class GameStateProvider with ChangeNotifier {
  final logger = Logger();
  final AnimationService _animationService = AnimationService();
  final GameService _gameService = GameService();
  final GameState _gameState = GameState();

  int _currentUserIndex = 0;

  // Getter to access the game state
  GameState get gameState => _gameState;

  // User presses buttons in order they were presented from buttonSequence
  void checkInput(int value) {
    makeNoise(value);
    if (gameState.buttonSequence.isEmpty) {
      return; //Game is not on do nothing
    }
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
      logger.d('Lose scenario. Score: ${_currentUserIndex + 1}');
      _reset();
    }
  }

  void startNewGame() {
    _reset();
    _nextLevel();
    startAnimation();
  }

  void _reset() {
    gameState.buttonSequence = [];
    gameState.animatedButton = 0;
    _currentUserIndex = 0;
  }

  void _nextLevel() {
    _gameService.nextLevel(_gameState.buttonSequence, notifyListeners);
  }

  //Animate the button sequence
  Future<void> startAnimation() async {
    await _animationService.startAnimation(_gameState.buttonSequence,
        (int animatedButton) {
      _gameState.animatedButton = animatedButton;
    }, notifyListeners, makeNoise);
  }
}
