import 'package:flutter/material.dart';

Widget gameButton({
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
