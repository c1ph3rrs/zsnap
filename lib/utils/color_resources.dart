import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as ad;

class AndroidColorResources {
  // Primary Colors - Based on main brand color #FDA521
  static const ad.Color COLOR_PRIMARY = ad.Color(0xFFfda521);
  static const ad.Color COLOR_PRIMARY_LIGHT =
      ad.Color(0xFFfec164); // Lighter shade
  static const ad.Color COLOR_PRIMARY_DARK =
      ad.Color(0xFFd88511); // Darker shade

  // Secondary Colors - Complementary to primary
  static const ad.Color COLOR_SECONDARY =
      ad.Color(0xFF21A5FD); // Blue complement
  static const ad.Color COLOR_SECONDARY_LIGHT = ad.Color(0xFF64C1FE);
  static const ad.Color COLOR_SECONDARY_DARK = ad.Color(0xFF1185D8);

  // Accent Colors - Supporting palette
  static const ad.Color ACCENT_BLUE = ad.Color(0xFF4a90e2);
  static const ad.Color ACCENT_GREEN =
      ad.Color(0xFF4CAF50); // More balanced green
  static const ad.Color ACCENT_RED = ad.Color(0xFFE53935); // Warmer red

  // Neutral Colors
  static const ad.Color WHITE = ad.Color(0xFFffffff);
  static const ad.Color BLACK = ad.Color(0xFF000000);
  static const ad.Color GRAY_LIGHT = ad.Color(0xFFF5F5F5);
  static const ad.Color GRAY_MEDIUM =
      ad.Color(0xFFBDBDBD); // More balanced gray
  static const ad.Color GRAY_DARK = ad.Color(0xFF424242); // Darker for contrast
}

class IOSColorResources {
  // Primary Colors - Based on main brand color #FDA521
  static const Color COLOR_PRIMARY = Color(0xFFfda521);
  static const Color COLOR_PRIMARY_LIGHT = Color(0xFFfec164); // Lighter shade
  static const Color COLOR_PRIMARY_DARK = Color(0xFFd88511); // Darker shade

  // Secondary Colors - Complementary to primary
  static const Color COLOR_SECONDARY = Color(0xFF21A5FD); // Blue complement
  static const Color COLOR_SECONDARY_LIGHT = Color(0xFF64C1FE);
  static const Color COLOR_SECONDARY_DARK = Color(0xFF1185D8);

  // Accent Colors - Supporting palette
  static const Color ACCENT_BLUE = Color(0xFF4a90e2);
  static const Color ACCENT_GREEN = Color(0xFF4CAF50); // More balanced green
  static const Color ACCENT_RED = Color(0xFFE53935); // Warmer red

  // Neutral Colors
  static const Color WHITE = Color(0xFFffffff);
  static const Color BLACK = Color(0xFF000000);
  static const Color GRAY_LIGHT = Color(0xFFF5F5F5);
  static const Color GRAY_MEDIUM = Color(0xFFBDBDBD); // More balanced gray
  static const Color GRAY_DARK = Color(0xFF424242); // Darker for contrast
}
