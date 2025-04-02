import 'package:flutter/material.dart';
import '../widgets/palindrome_screen_history_section.dart';
import '../widgets/palindrome_screen_input_section.dart';

class PalindromeCheckerScreen extends StatelessWidget {
  const PalindromeCheckerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          PalindromeScreenInputSection(),
          PalindromeScreenHistorySection()
        ],
      )
    );
  }
}
