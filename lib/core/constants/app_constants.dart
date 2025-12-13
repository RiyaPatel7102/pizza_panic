/// Application-wide constants
class AppConstants {
  AppConstants._();

  // ============================================
  // App Information
  // ============================================

  static const String appName = 'Pizza Panic';
  static const String appTagline = "Mamma Mia's Pizza Palace";

  // ============================================
  // Order Status Constants
  // ============================================

  static const String statusPreparing = 'preparing';
  static const String statusOnTheWay = 'onTheWay';
  static const String statusDelivered = 'delivered';

  // Status display names
  static const Map<String, String> statusDisplayNames = {
    statusPreparing: '🟠 Preparing',
    statusOnTheWay: '🔵 On the Way',
    statusDelivered: '🟢 Delivered',
  };

  // ============================================
  // Order Status Flow
  // ============================================

  static const List<String> orderStatusFlow = [
    statusPreparing,
    statusOnTheWay,
    statusDelivered,
  ];

  // Status stepper labels
  static const List<String> statusStepperLabels = [
    'Order Placed',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];

  // ============================================
  // Animation Durations
  // ============================================

  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  // ============================================
  // UI Constants
  // ============================================

  static const double orderCardHeight = 120.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavHeight = 80.0;

  // ============================================
  // Formatting
  // ============================================

  static const String dateTimeFormat = 'MMM dd, yyyy • hh:mm a';
  static const String timeOnlyFormat = 'hh:mm a';
  static const String dateOnlyFormat = 'MMM dd, yyyy';
  static const String currencySymbol = '\$';

  // ============================================
  // Asset Paths
  // ============================================

  static const String mockDataPath = 'assets/mock_data/orders_mock.json';
  static const String emptyOrdersImage = 'assets/images/empty_orders.png';
}
