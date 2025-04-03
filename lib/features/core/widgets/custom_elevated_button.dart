import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/features/core/constants/colors.dart';

class CustomElevatedButton {
  static Widget elevatedButton({
    required String buttonText,
    required Function? onPressedFunction,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        textStyle: const TextStyle(color: buttonTextColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      onPressed: onPressedFunction != null ? () => onPressedFunction() : null,
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}