import 'dart:math';

class GameService {
  // Timer? _animationTimer;
  // int _animatedButtonIndex = 0;

  void nextLevel(List<int> currentSequence, Function notifyListeners) {
    currentSequence = _pushRandomNumber(currentSequence);
    notifyListeners();
  }

  List<int> _pushRandomNumber(List<int> sequence) {
    var random = Random();
    int randomNumber = random.nextInt(5) + 1;
    sequence.add(randomNumber);
    return sequence;
  }
}
