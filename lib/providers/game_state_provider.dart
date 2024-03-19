import 'package:flutter/material.dart';
import 'package:simms_says/models/game_state.dart';
import 'package:logger/logger.dart';
import 'package:simms_says/services/animation_services.dart';

import 'dart:math';

class GameStateProvider with ChangeNotifier {
  final logger = Logger();
  final AnimationService _animationService = AnimationService();
  final GameState _gameState = GameState();

  int _currentUserIndex = 0;

  // Getter to access the game state
  GameState get gameState => _gameState;

  // Method to update the button sequence
  void updateButtonSequence(List<int> newSequence) {
    _gameState.buttonSequence = newSequence;
    notifyListeners(); // Notify listeners about the change
  }

  void checkInput(int value) {
    bool isValid = value == gameState.buttonSequence[_currentUserIndex];
    // Input is correct and reached the end of sequence
    if (isValid && _currentUserIndex == gameState.buttonSequence.length - 1) {
      logger.d('Good next round');
      _pushRandomNumber();
      _currentUserIndex = 0;
      startAnimation();
    }
    // Input is valid but there are more to go in the sequence.
    else if (isValid) {
      _currentUserIndex++;
    } else {
      //Lose scenario
      logger.d('Lose scenario. Score: ${_currentUserIndex + 1}');
      _reset();
    }
  }

  void startNewGame() {
    logger.d('new game initiated!');
    _gameState.buttonSequence = [];
    _pushRandomNumber();
    startAnimation();
  }

  void _reset() {
    logger.d('reset');
    gameState.buttonSequence = [];
    gameState.animatedButton = 0;
    _currentUserIndex = 0;
  }

  void _pushRandomNumber() {
    var random = Random();
    int randomNumber = random.nextInt(5) + 1;
    gameState.buttonSequence.add(randomNumber);
  }

  void startAnimation() {
    _animationService.startAnimation(_gameState.buttonSequence,
        (int animatedButton) {
      _gameState.animatedButton = animatedButton;
    }, notifyListeners);
  }
}
