import 'dart:async';
import 'package:simms_says/services/audio_services.dart';

class AnimationService {
  Timer? _animationTimer;
  int _animatedButtonIndex = 0;

  Future<void> startAnimation(List<int> buttonSequence,
      Function updateAnimatedButton, Function notifyListeners) {
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _animatedButtonIndex = 0; // Reset the index

    // Add a delay before starting the animation
    return Future.delayed(const Duration(milliseconds: 750), () {
      _animateNextButton(buttonSequence, updateAnimatedButton, notifyListeners);
    });
  }

  void _animateNextButton(List<int> buttonSequence,
      Function updateAnimatedButton, Function notifyListeners) {
    if (_animatedButtonIndex < buttonSequence.length) {
      // Animate the button at _animatedButtonIndex
      updateAnimatedButton(
          buttonSequence[_animatedButtonIndex]); //animateButton
      makeNoise(buttonSequence[_animatedButtonIndex]); //play tone
      notifyListeners();

      // Schedule the next animation
      _animationTimer = Timer(const Duration(milliseconds: 750), () {
        // Set animatedButton to 0 for 200ms before the next animation
        // This visually shows when a button is called twice.
        updateAnimatedButton(0);
        notifyListeners();

        Timer(const Duration(milliseconds: 200), () {
          _animateNextButton(
              buttonSequence, updateAnimatedButton, notifyListeners);
        });
      });
      _animatedButtonIndex++;
    } else {
      // Animation sequence completed
      updateAnimatedButton(0);
      notifyListeners();

      _animationTimer?.cancel();
      _animationTimer = null;
    }
  }
}
