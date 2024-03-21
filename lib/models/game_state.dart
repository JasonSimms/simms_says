class GameState {
  // Define properties and methods for your game state here
  List<int> buttonSequence = [];
  String stringFromProvider = 'BINGO';
  bool isLoading = true;
  bool isAnimatingSequence = false;
  int animatedButton = 0;
  List<int> userInputSequence = [];

  get handleUserInput => null;
}
