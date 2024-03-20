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
    final checkInput =
        Provider.of<GameStateProvider>(context, listen: false).checkInput;

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
                            label: 'Top Left',
                            value: 1,
                            color: Colors.green,
                            isAnimated: animatedButton == 1,
                            callback: checkInput),
                      ),
                      Expanded(
                        child: _buildButton(
                            label: 'Top Right',
                            value: 2,
                            color: Colors.red,
                            isAnimated: animatedButton == 2,
                            callback: checkInput),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildButton(
                              label: 'Bottom Left',
                              value: 3,
                              color: Colors.yellow,
                              isAnimated: animatedButton == 3,
                              callback: checkInput)),
                      Expanded(
                          child: _buildButton(
                              label: 'Bottom Right',
                              value: 4,
                              color: Colors.blue,
                              isAnimated: animatedButton == 4,
                              callback: checkInput)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.0, // Center the circle vertically
              left: 100.0, // Center the circle horizontally
              child: _buildButton(
                  label: 'Center',
                  value: 5,
                  color: Colors.purple,
                  isAnimated: animatedButton == 5,
                  callback: checkInput,
                  isCentered: true),
            ),
            Positioned(
                bottom: 50, right: 50, child: Text(animatedButton.toString()))
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required int value,
    required MaterialColor color,
    required bool isAnimated,
    required Function callback,
    bool isCentered = false,
  }) {
    return ElevatedButton(
      onPressed: () => callback(value),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: isAnimated ? Colors.orange : color,
        fixedSize: isCentered ? const Size(100, 100) : const Size(200, 200),
        shape: isCentered
            ? const CircleBorder()
            : const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: const Text(
        "",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
