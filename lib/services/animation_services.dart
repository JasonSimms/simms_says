import 'dart:async';

class AnimationService {
  Timer? _animationTimer;
  int _animatedButtonIndex = 0;

  void startAnimation(List<int> buttonSequence, Function updateAnimatedButton,
      Function notifyListeners) {
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _animatedButtonIndex = 0; // Reset the index

    // Add a delay before starting the animation
    Future.delayed(const Duration(milliseconds: 750), () {
      _animateNextButton(buttonSequence, updateAnimatedButton, notifyListeners);
    });
  }

  void _animateNextButton(List<int> buttonSequence,
      Function updateAnimatedButton, Function notifyListeners) {
    if (_animatedButtonIndex < buttonSequence.length) {
      // Animate the button at _animatedButtonIndex
      // This part is UI-specific and should be handled by the UI
      // For example, you might set a variable in your UI to reflect the current animated button
      // notifyListeners(); // Notify listeners to update the UI
      updateAnimatedButton(buttonSequence[_animatedButtonIndex]);
      notifyListeners();

      // Schedule the next animation
      _animationTimer = Timer(
          const Duration(milliseconds: 750),
          () => _animateNextButton(
              buttonSequence, updateAnimatedButton, notifyListeners));
      _animatedButtonIndex++;
    } else {
      // Animation sequence completed
      // Reset or set a variable in your UI to indicate no animation is happening
      updateAnimatedButton(0);
      notifyListeners();

      _animationTimer?.cancel();
      _animationTimer = null;
    }
  }
}
