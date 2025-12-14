import 'package:pizza_panic/features/orders/domain/entities/pizza.dart';
import 'package:pizza_panic/features/orders/domain/entities/pizza_size.dart';

/// Pizza data model for JSON serialization
/// Uses String for JSON, converts to PizzaSize enum for domain entity
class PizzaModel {
  const PizzaModel({
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
    required this.toppings,
    this.imageUrl,
  });

  final String name;
  final String size; // Stored as String for JSON (e.g., "Large")
  final int quantity;
  final double price;
  final List<String> toppings;
  final String? imageUrl;

  /// Create from JSON
  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      name: json['name'] as String,
      size: json['size'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      toppings:
          (json['toppings'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'size': size,
      'quantity': quantity,
      'price': price,
      'toppings': toppings,
      'imageUrl': imageUrl,
    };
  }

  /// Convert model to domain entity
  /// Converts String size to PizzaSize enum
  Pizza toEntity() {
    return Pizza(
      name: name,
      size: PizzaSize.fromString(size), // Convert String to enum
      quantity: quantity,
      price: price,
      toppings: toppings,
      imageUrl: imageUrl,
    );
  }

  /// Create model from domain entity
  /// Converts PizzaSize enum to String
  factory PizzaModel.fromEntity(Pizza pizza) {
    return PizzaModel(
      name: pizza.name,
      size: pizza.size.displayName, // Convert enum to String
      quantity: pizza.quantity,
      price: pizza.price,
      toppings: pizza.toppings,
      imageUrl: pizza.imageUrl,
    );
  }
}
