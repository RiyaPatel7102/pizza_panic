import 'package:pizza_panic/features/orders/data/datasources/orders_local_datasource.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/domain/repositories/orders_repository.dart';

/// Implementation of OrdersRepository
/// Handles data operations and converts between models and entities
class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersLocalDataSource _localDataSource;

  OrdersRepositoryImpl(this._localDataSource);

  @override
  Future<List<Order>> getAllOrders() async {
    try {
      final orderModels = await _localDataSource.getOrders();
      return orderModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  @override
  Future<Order?> getOrderById(String id) async {
    try {
      final orderModel = await _localDataSource.getOrderById(id);
      return orderModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  @override
  Future<List<Order>> getOrdersByStatus(OrderStatus status) async {
    try {
      final allOrders = await getAllOrders();
      return allOrders.where((order) => order.status == status).toList();
    } catch (e) {
      throw Exception('Failed to get orders by status: $e');
    }
  }

  @override
  Future<Order> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      final updatedModel = await _localDataSource.updateOrderStatus(
        orderId,
        newStatus.value,
      );
      return updatedModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  @override
  Future<List<Order>> refreshOrders() async {
    try {
      final orderModels = await _localDataSource.refreshOrders();
      return orderModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to refresh orders: $e');
    }
  }
}
