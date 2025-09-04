import 'package:flutter/material.dart'
    show ThemeData, CircularProgressIndicator;

import 'custom_filled_button_theme.dart' show CustomFilledButtonTheme;

ThemeData appTheme() {
  return ThemeData(filledButtonTheme: CustomFilledButtonTheme(
    loadingBuilder: (context, child) {
      return child ?? const CircularProgressIndicator();
    },
  ));
}
