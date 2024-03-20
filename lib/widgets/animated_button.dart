import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedPushButton extends StatefulWidget {
  @override
  _AnimatedPushButtonState createState() => _AnimatedPushButtonState();
}

class _AnimatedPushButtonState extends State<AnimatedPushButton> {
  Color _buttonColor = Colors.blue; // Original color of the button
  Timer? _timer;

  void _animateButton() {
    setState(() {
      _buttonColor = Colors.orange; // Change color to orange when "pushed"
    });

    _timer?.cancel(); // Cancel any ongoing timer
    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        _buttonColor = Colors.blue; // Change color back to original after delay
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animateButton();
        // Simulate the button being "pushed" twice
        Future.delayed(Duration(milliseconds: 1000), () {
          _animateButton();
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 100,
        height: 50,
        color: _buttonColor,
        child: Center(child: Text('Push Me')),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
