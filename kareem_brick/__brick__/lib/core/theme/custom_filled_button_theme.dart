import 'package:flutter/material.dart';

class CustomFilledButtonTheme extends FilledButtonThemeData {
  const CustomFilledButtonTheme({
    this.loadingBuilder,
  });
  final Widget Function(BuildContext context, Widget? child)? loadingBuilder;
}
