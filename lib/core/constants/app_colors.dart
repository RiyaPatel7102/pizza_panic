import 'package:flutter/material.dart';

/// App-wide color constants
/// Following Material 3 design system with custom pizza-themed colors
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ============================================
  // Status Colors (from requirements)
  // ============================================

  /// 🟠 Orange - Order is being prepared
  static const preparing = Color(0xFFF77F00);

  /// 🔵 Blue - Order is on the way
  static const onTheWay = Color(0xFF3A86FF);

  /// 🟢 Green - Order has been delivered
  static const delivered = Color(0xFF06D6A0);

  // ============================================
  // Brand Colors
  // ============================================

  /// Primary brand color - Pizza red/orange
  static const primaryColor = Color(0xFFFF6B35);

  /// Secondary brand color - Deep navy
  static const secondaryColor = Color(0xFF004E89);

  // ============================================
  // Semantic Colors
  // ============================================

  static const success = Color(0xFF2A9D8F);
  static const warning = Color(0xFFF77F00);
  static const error = Color(0xFFE63946);
  static const info = Color(0xFF3A86FF);

  // ============================================
  // Neutral Colors
  // ============================================

  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF666666);
  static const textTertiary = Color(0xFF999999);

  static const backgroundLight = Color(0xFFFAFAFA);
  static const backgroundDark = Color(0xFF121212);

  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark = Color(0xFF1E1E1E);

  static const divider = Color(0xFFE0E0E0);

  // ============================================
  // Status Color Map (for easy lookup)
  // ============================================

  static Map<String, Color> get statusColors => {
        'preparing': preparing,
        'onTheWay': onTheWay,
        'delivered': delivered,
      };

  /// Get color for a given status string
  static Color getStatusColor(String status) {
    return statusColors[status] ?? textSecondary;
  }
}

/// Design spacing tokens
/// Following 8px grid system
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// Border radius tokens
class AppRadius {
  AppRadius._();

  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double circular = 999.0;

  // Commonly used BorderRadius objects
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
}

/// Elevation levels (Material 3)
class AppElevation {
  AppElevation._();

  static const double level0 = 0.0;
  static const double level1 = 1.0;
  static const double level2 = 3.0;
  static const double level3 = 6.0;
  static const double level4 = 8.0;
  static const double level5 = 12.0;
}
