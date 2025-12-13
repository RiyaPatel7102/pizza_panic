import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/domain/entities/pizza.dart';

/// Order entity
/// Represents a pizza order with all its details
class Order {
  const Order({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.pizzas,
    required this.status,
    required this.orderTime,
    required this.estimatedDeliveryTime,
    required this.totalAmount,
    this.deliveryTime,
    this.specialInstructions,
  });

  final String id;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final List<Pizza> pizzas;
  final OrderStatus status;
  final DateTime orderTime;
  final DateTime estimatedDeliveryTime;
  final DateTime? deliveryTime;
  final double totalAmount;
  final String? specialInstructions;

  /// Get formatted total amount
  String get formattedTotal => '\$${totalAmount.toStringAsFixed(2)}';

  /// Get number of pizzas in order
  int get pizzaCount => pizzas.fold(0, (sum, pizza) => sum + pizza.quantity);

  /// Get pizza names as comma-separated string
  String get pizzaNamesDisplay {
    if (pizzas.isEmpty) return 'No pizzas';
    if (pizzas.length == 1) return pizzas.first.name;
    if (pizzas.length == 2) {
      return '${pizzas[0].name} and ${pizzas[1].name}';
    }
    return '${pizzas[0].name} and ${pizzas.length - 1} more';
  }

  /// Check if order has special instructions
  bool get hasSpecialInstructions =>
      specialInstructions != null && specialInstructions!.isNotEmpty;

  /// Check if order is delivered
  bool get isDelivered => status == OrderStatus.delivered;

  /// Check if order can be advanced to next status
  bool get canAdvance => status.canAdvance;

  /// Get the next status
  OrderStatus? get nextStatus => status.nextStatus;

  /// Get elapsed time since order was placed
  Duration get elapsedTime => DateTime.now().difference(orderTime);

  /// Get time until estimated delivery
  Duration get timeUntilDelivery {
    final now = DateTime.now();
    if (now.isAfter(estimatedDeliveryTime)) {
      return Duration.zero;
    }
    return estimatedDeliveryTime.difference(now);
  }

  /// Check if order is late (past estimated delivery time and not delivered)
  bool get isLate {
    if (isDelivered) return false;
    return DateTime.now().isAfter(estimatedDeliveryTime);
  }

  /// Create a copy with updated fields
  Order copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    List<Pizza>? pizzas,
    OrderStatus? status,
    DateTime? orderTime,
    DateTime? estimatedDeliveryTime,
    DateTime? deliveryTime,
    double? totalAmount,
    String? specialInstructions,
  }) {
    return Order(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerAddress: customerAddress ?? this.customerAddress,
      pizzas: pizzas ?? this.pizzas,
      status: status ?? this.status,
      orderTime: orderTime ?? this.orderTime,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      totalAmount: totalAmount ?? this.totalAmount,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Order(id: $id, customer: $customerName, status: ${status.displayName})';
  }
}
