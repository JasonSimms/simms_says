import 'package:flutter/material.dart';
import 'package:simms_says/models/game_state.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'dart:math';

class GameStateProvider with ChangeNotifier {
  final logger = Logger();
  final GameState _gameState = GameState();

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
      logger.d('gj got to the end lets go further');
      _pushRandomNumber();
      _currentUserIndex = 0;
      startAnimation();
    }
    // Input is valid but there are more to go in the sequence.
    else if (isValid) {
      logger.d('gj do another');
      _currentUserIndex++;
    } else {
      //Lose scenario
      logger.d('To bad try again you got to ${_currentUserIndex + 1}');
      _reset();
    }
  }

  int _currentUserIndex = 0;
  int _currentButtonIndex = 0;
  Timer? _animationTimer;

  void startAnimation() {
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _currentButtonIndex = 0; // Reset the index
    // Add a delay before starting the animation
    Future.delayed(Duration(milliseconds: 750), () {
      _animateNextButton();
    });
  }

  void _animateNextButton() {
    //TODO: this needs to show somehow when 1 button blinks twice! also add sound!
    if (_currentButtonIndex < gameState.buttonSequence.length) {
      // Animate the button at _currentButtonIndex
      gameState.animatedButton = gameState.buttonSequence[_currentButtonIndex];
      notifyListeners(); // Notify listeners to update the UI

      // Schedule the next animation
      _animationTimer = Timer(Duration(milliseconds: 750), _animateNextButton);
      _currentButtonIndex++;
    } else {
      // Animation sequence completed
      gameState.animatedButton = 0;
      notifyListeners();
      _animationTimer?.cancel();
      _animationTimer = null;
    }
  }

  void startNewGame() {
    logger.d('new game initiated!');
    gameState.buttonSequence = [];
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
}
