import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';

/// Orders repository interface
/// Defines the contract for order data operations
/// This is an abstract class that will be implemented by the data layer
abstract class OrdersRepository {
  /// Get all orders
  Future<List<Order>> getAllOrders();

  /// Get a single order by ID
  Future<Order?> getOrderById(String id);

  /// Get orders filtered by status
  Future<List<Order>> getOrdersByStatus(OrderStatus status);

  /// Update order status
  /// Returns updated order or throws exception on failure
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus);

  /// Refresh orders (reload from source)
  Future<List<Order>> refreshOrders();
}
