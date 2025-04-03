import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_checker_app/features/core/widgets/custom_elevated_button.dart';
import 'package:palindrome_checker_app/features/palindrome/presentation/bloc/palindrome_bloc.dart';

class PalindromeScreenHistorySection extends StatelessWidget {
  const PalindromeScreenHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PalindromeBloc, PalindromeState>(
      builder: (context, state) {
        if (state is PalindromeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PalindromeLoaded) {
          final history = state.palindromes;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final result = history[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(0.2)),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.input, color: Colors.white),
                              title: Text(
                                result.input,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                result.isPalindrome ? "Palindrome" : "Not a Palindrome",
                                style: TextStyle(
                                  color: result.isPalindrome ? Colors.green : Colors.red,
                                ),
                              ),
                              trailing: Text(
                                result.timeStamp,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomElevatedButton.elevatedButton(
                  onPressedFunction: () {
                    context.read<PalindromeBloc>().add(const ClearHistoryEvent());
                  },
                  buttonText:  "Clear History",
                ),
              ),
            ],
          );
        } else {
          return const Center(child: Text("No history available"));
        }
      },
    );
  }
}
