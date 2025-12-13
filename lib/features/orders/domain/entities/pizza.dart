import 'package:pizza_panic/features/orders/domain/entities/pizza_size.dart';

/// Pizza entity
/// Represents a single pizza item in an order
class Pizza {
  const Pizza({
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
    required this.toppings,
    this.imageUrl,
  });

  final String name;
  final PizzaSize size;
  final int quantity;
  final double price;
  final List<String> toppings;
  final String? imageUrl;

  /// Calculate total price for this pizza (price * quantity)
  double get totalPrice => price * quantity;

  /// Get formatted price string
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  /// Get formatted total price string
  String get formattedTotalPrice => '\$${totalPrice.toStringAsFixed(2)}';

  /// Get toppings as comma-separated string
  String get toppingsDisplay => toppings.join(', ');

  /// Get size display name
  String get sizeDisplay => size.displayName;

  /// Create a copy with updated fields
  Pizza copyWith({
    String? name,
    PizzaSize? size,
    int? quantity,
    double? price,
    List<String>? toppings,
    String? imageUrl,
  }) {
    return Pizza(
      name: name ?? this.name,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      toppings: toppings ?? this.toppings,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pizza &&
        other.name == name &&
        other.size == size &&
        other.quantity == quantity &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        _listEquals(other.toppings, toppings);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        size.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        toppings.hashCode;
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'Pizza(name: $name, size: ${size.displayName}, quantity: $quantity, price: $price)';
  }
}
