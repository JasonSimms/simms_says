import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class GameBoard extends StatelessWidget {
  GameBoard({
    super.key,
  });

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
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
                          child: _buildButton('Top Left',
                              'Top Left button pressed', Colors.green)),
                      Expanded(
                          child: _buildButton('Top Right',
                              'Top Right button pressed', Colors.red)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildButton('Bottom Left',
                              'Bottom Left button pressed', Colors.yellow)),
                      Expanded(
                          child: _buildButton('Bottom Right',
                              'Bottom Right button pressed', Colors.blue)),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.0, // Center the circle vertically
              left: 100.0, // Center the circle horizontally
              child: _buildCenterButton('Center', 'Center button pressed'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, String logMessage, MaterialColor color) {
    return ElevatedButton(
      onPressed: () => logger.d(logMessage),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color, // Uncomment if you want to set the text color
        fixedSize: const Size(200, 200),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero), // Makes the button square
        // padding: EdgeInsets.all(
        //     size / 4), // Adjusts the padding to fit the square shape
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildCenterButton(String label, String logMessage,
      [double size = 100.0]) {
    return ElevatedButton(
      onPressed: () => logger.d(logMessage),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor:
            Colors.purple, // Uncomment if you want to set the text color
        fixedSize: const Size(100, 100),
        shape: const CircleBorder(), // Makes the button square
        // padding: EdgeInsets.all(
        //     size / 4), // Adjusts the padding to fit the square shape
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
