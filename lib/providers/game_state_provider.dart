import 'package:flutter/material.dart';
import 'package:simms_says/models/game_state.dart';
import 'package:logger/logger.dart';
import 'dart:async';

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

  int _currentButtonIndex = 0;
  Timer? _animationTimer;

  void startAnimation() {
    print('letsgo');
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _currentButtonIndex = 0; // Reset the index
    _animateNextButton();
  }

  void _animateNextButton() {
    print('next animation...');
    if (_currentButtonIndex < gameState.buttonSequence.length) {
      // Animate the button at _currentButtonIndex
      // This could involve changing its state or appearance
      // For example, changing a boolean flag in a list that controls the button's appearance
      gameState.animatedButton = gameState.buttonSequence[_currentButtonIndex];
      notifyListeners(); // Notify listeners to update the UI

      // Schedule the next animation
      _animationTimer = Timer(Duration(seconds: 1), _animateNextButton);
      _currentButtonIndex++;
    } else {
      // Animation sequence completed
      print('all done...?');
      gameState.animatedButton = 0;
      notifyListeners();

      _animationTimer?.cancel();
      _animationTimer = null;
    }
  }
}
