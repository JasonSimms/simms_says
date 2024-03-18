import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simms_says/widgets/game_board.dart';
import 'package:simms_says/providers/game_state_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameStateProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameStateProvider>(context).gameState;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Coder_Simms_Says'),
          ),
          body: Column(children: <Widget>[
            Text(gameState.stringFromProvider),
            Container(
                width: 400,
                height: 400,
                color: Colors.grey,
                child: GameBoard()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation in GameBoard
                    Provider.of<GameStateProvider>(context, listen: false)
                        .updateButtonSequence([1, 2, 3, 4, 5]);
                  },
                  child: const Text('Update Sequence'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation in GameBoard
                    Provider.of<GameStateProvider>(context, listen: false)
                        .startAnimation();
                  },
                  child: const Text('Animate Buttons'),
                ),
              ],
            )
          ])
          //
          ),
    );
  }
}
