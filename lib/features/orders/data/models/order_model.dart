import 'package:pizza_panic/features/orders/data/models/pizza_model.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';

/// Order data model for JSON serialization
/// Uses String for JSON, converts to OrderStatus enum for domain entity
class OrderModel {
  const OrderModel({
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
  final List<PizzaModel> pizzas;
  final String status; // Stored as String for JSON (e.g., "preparing")
  final String orderTime;
  final String estimatedDeliveryTime;
  final String? deliveryTime;
  final double totalAmount;
  final String? specialInstructions;

  /// Create from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String,
      customerAddress: json['customerAddress'] as String,
      pizzas: (json['pizzas'] as List<dynamic>)
          .map((e) => PizzaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      orderTime: json['orderTime'] as String,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] as String,
      deliveryTime: json['deliveryTime'] as String?,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      specialInstructions: json['specialInstructions'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'pizzas': pizzas.map((p) => p.toJson()).toList(),
      'status': status,
      'orderTime': orderTime,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'deliveryTime': deliveryTime,
      'totalAmount': totalAmount,
      'specialInstructions': specialInstructions,
    };
  }

  /// Convert model to domain entity
  /// Converts String status to OrderStatus enum
  Order toEntity() {
    return Order(
      id: id,
      customerName: customerName,
      customerPhone: customerPhone,
      customerAddress: customerAddress,
      pizzas: pizzas.map((p) => p.toEntity()).toList(), // Converts size to enum
      status: OrderStatus.fromString(status), // Convert String to enum
      orderTime: DateTime.parse(orderTime),
      estimatedDeliveryTime: DateTime.parse(estimatedDeliveryTime),
      deliveryTime: deliveryTime != null ? DateTime.parse(deliveryTime!) : null,
      totalAmount: totalAmount,
      specialInstructions: specialInstructions,
    );
  }

  /// Create model from domain entity
  /// Converts OrderStatus enum to String
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      customerName: order.customerName,
      customerPhone: order.customerPhone,
      customerAddress: order.customerAddress,
      pizzas: order.pizzas.map((p) => PizzaModel.fromEntity(p)).toList(),
      status: order.status.value, // Convert enum to String
      orderTime: order.orderTime.toIso8601String(),
      estimatedDeliveryTime: order.estimatedDeliveryTime.toIso8601String(),
      deliveryTime: order.deliveryTime?.toIso8601String(),
      totalAmount: order.totalAmount,
      specialInstructions: order.specialInstructions,
    );
  }

  /// Create a copy with updated fields
  OrderModel copyWith({
    String? id,
    String? customerName,
    String? customerPhone,
    String? customerAddress,
    List<PizzaModel>? pizzas,
    String? status,
    String? orderTime,
    String? estimatedDeliveryTime,
    String? deliveryTime,
    double? totalAmount,
    String? specialInstructions,
  }) {
    return OrderModel(
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
}
