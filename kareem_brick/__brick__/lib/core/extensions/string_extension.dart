extension StringExtension on String {
  /// Reverses the string.
  String get reverseText => split('').reversed.join();

  /// Capitalize the first letter
  String capitalize() => isEmpty ? this : this[0].toUpperCase() + substring(1);
}
