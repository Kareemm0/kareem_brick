import 'package:flutter/widgets.dart' show HSLColor, Color;

extension ColorExtensions on Color {
  /// Convert hex string to Color.
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  // Darken a color.
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  // Lighten a color.
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}
