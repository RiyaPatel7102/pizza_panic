import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/features/orders/data/models/order_model.dart';

/// Local data source for orders
/// Loads mock data from JSON file
class OrdersLocalDataSource {
  // In-memory cache of orders
  List<OrderModel>? _cachedOrders;

  /// Get all orders from JSON file
  Future<List<OrderModel>> getOrders() async {
    // Return cached data if available
    if (_cachedOrders != null) {
      return _cachedOrders!;
    }

    try {
      // Load JSON file
      final jsonString = await rootBundle.loadString(
        AppConstants.mockDataPath,
      );

      // Parse JSON
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final ordersJson = jsonData['orders'] as List<dynamic>;

      // Convert to models
      _cachedOrders = ordersJson
          .map(
            (orderJson) =>
                OrderModel.fromJson(orderJson as Map<String, dynamic>),
          )
          .toList();

      return _cachedOrders!;
    } catch (e) {
      throw Exception('Failed to load orders: $e');
    }
  }

  /// Get single order by ID
  Future<OrderModel?> getOrderById(String id) async {
    final orders = await getOrders();
    try {
      return orders.firstWhere((order) => order.id == id);
    } catch (e) {
      return null; // Order not found
    }
  }

  /// Update order status
  /// In real app, this would persist to database/API
  /// For mock data, we update in-memory cache
  Future<OrderModel> updateOrderStatus(String orderId, String newStatus) async {
    final orders = await getOrders();

    // Find order index
    final orderIndex = orders.indexWhere((order) => order.id == orderId);

    if (orderIndex == -1) {
      throw Exception('Order not found: $orderId');
    }

    // Create updated order
    final updatedOrder = orders[orderIndex].copyWith(
      status: newStatus,
      // If status is delivered, set delivery time
      deliveryTime: newStatus == 'delivered'
          ? DateTime.now().toIso8601String()
          : orders[orderIndex].deliveryTime,
    );

    // Update cache
    _cachedOrders![orderIndex] = updatedOrder;

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return updatedOrder;
  }

  /// Refresh orders (reload from JSON)
  Future<List<OrderModel>> refreshOrders() async {
    _cachedOrders = null; // Clear cache
    return await getOrders();
  }

  /// Clear cache
  void clearCache() {
    _cachedOrders = null;
  }
}
