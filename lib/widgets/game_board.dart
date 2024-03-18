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
                          child: _buildButton(
                              'Top Left', 'Top Left button pressed')),
                      Expanded(
                          child: _buildButton(
                              'Top Right', 'Top Right button pressed')),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: _buildButton(
                              'Bottom Left', 'Bottom Left button pressed')),
                      Expanded(
                          child: _buildButton(
                              'Bottom Right', 'Bottom Right button pressed')),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.0, // Center the circle vertically
              left: 100.0, // Center the circle horizontally
              child:
                  _buildCenterButton('Center', 'Center button pressed', 100.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, String logMessage, [double size = 100.0]) {
    return ElevatedButton(
      onPressed: () => logger.d(logMessage),
      style: ElevatedButton.styleFrom(
        // primary: Colors.blue, // Uncomment if you want to set the background color
        // onPrimary: Colors.white, // Uncomment if you want to set the text color
        fixedSize: Size(200, 200),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero), // Makes the button square
        // padding: EdgeInsets.all(
        //     size / 4), // Adjusts the padding to fit the square shape
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildCenterButton(String label, String logMessage,
      [double size = 100.0]) {
    return GestureDetector(
      onTap: () => logger.d(logMessage),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.green,
          border: Border.all(
            color: Colors.white, // Border color
            width: 2.0, // Border width
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
