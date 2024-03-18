import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:simms_says/providers/game_state_provider.dart';

class GameBoard extends StatelessWidget {
  final logger = Logger();

  GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    // State from provider
    final gameState = Provider.of<GameStateProvider>(context).gameState;
    final animatedButton = gameState.animatedButton;
    // print(buttonSequence);
    // animateButtons(buttonSequence);
    return Center(
      child: Container(
        width: 300.0, // Adjust the width as needed
        height: 300.0, // Adjust the height as needed
        color: Colors.green, // Background color for the container
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildButton(
                              'Top Left',
                              'Top Left button pressed',
                              Colors.green,
                              animatedButton == 1)),
                      Expanded(
                          child: _buildButton(
                              'Top Right',
                              'Top Right button pressed',
                              Colors.red,
                              animatedButton == 2)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildButton(
                              'Bottom Left',
                              'Bottom Left button pressed',
                              Colors.yellow,
                              animatedButton == 3)),
                      Expanded(
                          child: _buildButton(
                              'Bottom Right',
                              'Bottom Right button pressed',
                              Colors.blue,
                              animatedButton == 4)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.0, // Center the circle vertically
              left: 100.0, // Center the circle horizontally
              child: _buildButton('Center', 'Center button pressed',
                  Colors.purple, animatedButton == 5,
                  isCentered: true),
            ),
            Positioned(
                bottom: 50, right: 50, child: Text(animatedButton.toString()))
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      String label, String logMessage, MaterialColor color, bool isAnimated,
      {bool isCentered = false}) {
    return ElevatedButton(
      onPressed: () => logger.d(logMessage),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isAnimated ? Colors.orange : color,
        fixedSize: isCentered ? Size(100, 100) : Size(200, 200),
        shape: isCentered
            ? CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
