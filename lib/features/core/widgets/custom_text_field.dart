import 'package:flutter/material.dart';
import 'package:palindrome_checker_app/features/core/constants/colors.dart';

class CustomTextFormField {
  static Widget textFormField({
    required String labelText,
    required TextEditingController controller,
    Function? onChangedFunction,
    Function? validatorFunction,
  }) {
    return TextFormField(
      style: const TextStyle(color: textFieldTextColor, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelStyle: const  TextStyle(color: textFieldTextColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: textFieldBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: textFieldBorderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: textFieldBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        labelText: labelText,
        floatingLabelStyle: const TextStyle(height: 4, color: textFieldBorderColor),
        filled: true,
        fillColor: textFieldFillColor,
      ),
      validator:
      validatorFunction != null ? (value) => validatorFunction(value) : null,
      controller: controller,
      onChanged:
      onChangedFunction != null ? (value) => onChangedFunction(value) : null,
    );
  }
}