import 'dart:async';

class AnimationService {
  Timer? _animationTimer;
  int _animatedButtonIndex = 0;

  Future<void> startAnimation(List<int> buttonSequence,
      Function updateAnimatedButton, Function makeNoise) async {
    _animationTimer?.cancel(); // Cancel any ongoing animation
    _animatedButtonIndex = 0; // Reset the index

    // Create a completer to control the Future's completion
    final completer = Completer<void>();

    // Add a delay before starting the animation
    await Future.delayed(const Duration(milliseconds: 750));

    // Start the animation sequence
    await _animateNextButton(
        buttonSequence, updateAnimatedButton, makeNoise, completer.complete);

    return completer.future;
  }

  Future<void> _animateNextButton(
      List<int> buttonSequence,
      Function updateAnimatedButton,
      Function makeNoise,
      Function resolve) async {
    if (_animatedButtonIndex < buttonSequence.length) {
      // Animate the button at _animatedButtonIndex
      updateAnimatedButton(buttonSequence[_animatedButtonIndex]);
      makeNoise(buttonSequence[_animatedButtonIndex]);

      // Schedule the next animation
      _animationTimer = Timer(const Duration(milliseconds: 750), () async {
        // Set animatedButton to 0 for 200ms before the next animation
        updateAnimatedButton(0);

        // Wait for 200ms before proceeding to the next animation
        await Future.delayed(const Duration(milliseconds: 200));
        await _animateNextButton(
            buttonSequence, updateAnimatedButton, makeNoise, resolve);
      });
      _animatedButtonIndex++;
    } else {
      // Animation sequence completed
      updateAnimatedButton(0);
      _animationTimer?.cancel();
      _animationTimer = null;
      resolve(); // Complete the Future when the animation sequence is done
    }
  }
}
