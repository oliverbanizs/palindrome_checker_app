import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../widgets/palindrome_screen_history_section.dart';
import '../widgets/palindrome_screen_input_section.dart';

class PalindromeCheckerScreen extends StatelessWidget {
  const PalindromeCheckerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              PalindromeScreenInputSection(),
              Expanded(child: PalindromeScreenHistorySection())
            ],
          ),
        ),
      )
    );
  }
}
