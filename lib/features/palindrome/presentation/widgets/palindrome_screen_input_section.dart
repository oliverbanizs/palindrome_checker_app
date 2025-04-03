import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_checker_app/features/core/utils/validators.dart';
import 'package:palindrome_checker_app/features/core/widgets/custom_elevated_button.dart';
import 'package:palindrome_checker_app/features/core/widgets/custom_text_field.dart';
import 'package:palindrome_checker_app/features/palindrome/presentation/bloc/palindrome_bloc.dart';

class PalindromeScreenInputSection extends StatefulWidget {
  const PalindromeScreenInputSection({super.key});

  @override
  State<PalindromeScreenInputSection> createState() =>
      _PalindromeScreenInputSectionState();
}

class _PalindromeScreenInputSectionState
    extends State<PalindromeScreenInputSection> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomTextFormField.textFormField(
            labelText: "Input",
            controller: controller,
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return Validators.mandatoryField(value ?? '');
              }
              return null;
            },
            onChangedFunction: (selectedValue) {
              if (selectedValue != null) {
                setState(() {
                  controller.text = selectedValue;
                });
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomElevatedButton.elevatedButton(
              buttonText: "Submit",
              onPressedFunction: () {
                context
                    .read<PalindromeBloc>()
                    .add(CheckPalindromeEvent(controller.text));
                controller.clear();
              }),
        )
      ],
    );
  }
}
