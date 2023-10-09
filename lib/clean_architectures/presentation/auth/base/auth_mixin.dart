import 'package:flutter/material.dart';

mixin AuthMixin<T extends StatefulWidget> on State<T> {
  Color get primaryColor => Theme.of(context).primaryColor;

  Color get scaffoldBackgroundColor => Theme.of(context).scaffoldBackgroundColor;

  InputDecoration textFieldDecoration({
    required Widget suffixIcon,
    required String labelText,
    required String? errorText,
  }) =>
      InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          gapPadding: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
          gapPadding: 10,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          gapPadding: 10,
        ),
        labelText: labelText,
        errorText: errorText,
        suffixIcon: suffixIcon,
      );
}
