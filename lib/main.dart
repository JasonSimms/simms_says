import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simms_says/widgets/game_board.dart';
import 'package:simms_says/providers/game_state_provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameStateProvider>(context).gameState;
    final highScore = gameState.highScore;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Coder Simms Says'),
          ),
          body: Column(children: <Widget>[
            Text('Top Score: $highScore'),
            Container(
                width: 400,
                height: 400,
                color: gameState.isBusy
                    ? Colors.lightGreenAccent[100]
                    : Colors.grey,
                child: GameBoard()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation in GameBoard
                    Provider.of<GameStateProvider>(context, listen: false)
                        .startAnimation();
                  },
                  child: const Text('Help'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation in GameBoard
                    Provider.of<GameStateProvider>(context, listen: false)
                        .startNewGame();
                  },
                  child: const Text('New'),
                ),
              ],
            )
          ])
          //
          ),
    );
  }
}
