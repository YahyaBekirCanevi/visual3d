import 'dart:math';

import 'package:flutter/material.dart';

extension ColorExtension on Color {
  /// Adjusts the saturation of this color.
  ///
  /// [saturation] should be between 0.0 (inclusive) and 1.0 (inclusive).
  Color withSaturation(double saturation) {
    saturation = min(1, max(0, saturation));
    // Convert to HSL
    final HSLColor hslColor = HSLColor.fromColor(this);

    // Adjust saturation
    final HSLColor adjustedHSL = HSLColor.fromAHSL(
      hslColor.alpha,
      hslColor.hue,
      saturation,
      hslColor.lightness,
    );

    // Convert back to RGB
    return adjustedHSL.toColor();
  }
}
