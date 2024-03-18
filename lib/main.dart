import 'package:flutter/material.dart';
import 'package:simms_says/widgets/game_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coder_Simms_Says'),
        ),
        body: Center(
          child: Container(
              width: 400, height: 400, color: Colors.grey, child: GameBoard()),
        ),
      ),
    );
  }
}
