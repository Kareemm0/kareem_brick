import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  /// Returns true if the current orientation is portrait.
  bool get isPortrait => Orientation.portrait == MediaQuery.orientationOf(this);

  /// Returns true if the current orientation is landscape.
  bool get isLandscape =>
      Orientation.landscape == MediaQuery.orientationOf(this);

  /// Returns the [width] of the current context.
  double get width => MediaQuery.sizeOf(this).width;

  /// Returns the [height] of the current context.
  double get height => MediaQuery.sizeOf(this).height;

  /// Returns the [Theme] of the current context.
  ThemeData get theme => Theme.of(this);

  /// Returns the [colorScheme] of the current context.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the [textTheme] of the current context.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
