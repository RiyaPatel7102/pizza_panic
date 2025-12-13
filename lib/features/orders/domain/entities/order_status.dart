/// Order status enum
/// Represents the three stages of pizza order delivery
enum OrderStatus {
  preparing('preparing', '🟠 Preparing'),
  onTheWay('onTheWay', '🔵 On the Way'),
  delivered('delivered', '🟢 Delivered');

  const OrderStatus(this.value, this.displayName);

  final String value;
  final String displayName;

  /// Create OrderStatus from string value
  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => OrderStatus.preparing,
    );
  }

  /// Get the next status in the flow
  /// Returns null if already delivered
  OrderStatus? get nextStatus {
    switch (this) {
      case OrderStatus.preparing:
        return OrderStatus.onTheWay;
      case OrderStatus.onTheWay:
        return OrderStatus.delivered;
      case OrderStatus.delivered:
        return null; // No next status
    }
  }

  /// Check if this is the final status
  bool get isDelivered => this == OrderStatus.delivered;

  /// Check if order can be updated to next status
  bool get canAdvance => nextStatus != null;

  /// Get status index (for stepper)
  int get stepIndex {
    switch (this) {
      case OrderStatus.preparing:
        return 1;
      case OrderStatus.onTheWay:
        return 2;
      case OrderStatus.delivered:
        return 3;
    }
  }
}
