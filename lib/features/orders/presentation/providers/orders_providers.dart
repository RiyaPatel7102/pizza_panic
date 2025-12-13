import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/features/orders/data/datasources/orders_local_datasource.dart';
import 'package:pizza_panic/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/domain/repositories/orders_repository.dart';

// ============================================
// LAYER 1: Data Sources (Dependencies)
// ============================================

/// Provider for local data source
/// Singleton - created once and reused
final ordersLocalDataSourceProvider = Provider<OrdersLocalDataSource>((ref) {
  return OrdersLocalDataSource();
});

// ============================================
// LAYER 2: Repositories (Business Logic)
// ============================================

/// Provider for orders repository
/// Injects the data source dependency
final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  final dataSource = ref.watch(ordersLocalDataSourceProvider);
  return OrdersRepositoryImpl(dataSource);
});

// ============================================
// LAYER 3: State Management
// ============================================

/// Main orders state provider
/// Uses StateNotifier for complex state management
/// Handles loading, error, and data states with AsyncValue
final ordersNotifierProvider =
    StateNotifierProvider<OrdersNotifier, AsyncValue<List<Order>>>((ref) {
  final repository = ref.watch(ordersRepositoryProvider);
  return OrdersNotifier(repository);
});

/// Orders grouped by status
/// Automatically recomputes when orders change
final ordersByStatusProvider = Provider<Map<OrderStatus, List<Order>>>((ref) {
  final ordersAsync = ref.watch(ordersNotifierProvider);

  return ordersAsync.when(
    data: (orders) {
      return {
        OrderStatus.preparing:
            orders.where((o) => o.status == OrderStatus.preparing).toList(),
        OrderStatus.onTheWay:
            orders.where((o) => o.status == OrderStatus.onTheWay).toList(),
        OrderStatus.delivered:
            orders.where((o) => o.status == OrderStatus.delivered).toList(),
      };
    },
    loading: () => {
      OrderStatus.preparing: [],
      OrderStatus.onTheWay: [],
      OrderStatus.delivered: [],
    },
    error: (_, __) => {
      OrderStatus.preparing: [],
      OrderStatus.onTheWay: [],
      OrderStatus.delivered: [],
    },
  );
});

/// Get single order by ID
/// Uses family for parameterized providers
/// AutoDispose to prevent memory leaks
final orderDetailsProvider =
    FutureProvider.autoDispose.family<Order?, String>((ref, orderId) async {
  final repository = ref.watch(ordersRepositoryProvider);
  return await repository.getOrderById(orderId);
});

/// Get count of orders by status
/// Optimized with select to prevent unnecessary rebuilds
final orderCountByStatusProvider =
    Provider.family<int, OrderStatus>((ref, status) {
  final ordersByStatus = ref.watch(ordersByStatusProvider);
  return ordersByStatus[status]?.length ?? 0;
});

/// Total number of orders
final totalOrdersCountProvider = Provider<int>((ref) {
  final ordersAsync = ref.watch(ordersNotifierProvider);
  return ordersAsync.when(
    data: (orders) => orders.length,
    loading: () => 0,
    error: (_, __) => 0,
  );
});

// ============================================
// OrdersNotifier - State Management Logic
// ============================================

/// StateNotifier for managing orders state
/// Handles loading, updating, and refreshing orders
class OrdersNotifier extends StateNotifier<AsyncValue<List<Order>>> {
  final OrdersRepository _repository;

  OrdersNotifier(this._repository) : super(const AsyncValue.loading()) {
    // Load orders immediately on creation
    loadOrders();
  }

  /// Load all orders from repository
  Future<void> loadOrders() async {
    // Set loading state
    state = const AsyncValue.loading();

    // Use AsyncValue.guard to handle success and error
    state = await AsyncValue.guard(() => _repository.getAllOrders());
  }

  /// Update order status to next stage
  /// Uses optimistic update for better UX
  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    // Optimistic update - update UI immediately
    state.whenData((orders) {
      final updatedOrders = orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(
            status: newStatus,
            // Set delivery time if status is delivered
            deliveryTime: newStatus == OrderStatus.delivered
                ? DateTime.now()
                : order.deliveryTime,
          );
        }
        return order;
      }).toList();

      // Update state with optimistic data
      state = AsyncValue.data(updatedOrders);
    });

    // Actual update to repository
    try {
      await _repository.updateOrderStatus(orderId, newStatus);
      // Success - optimistic update was correct
    } catch (e, stackTrace) {
      // Error - rollback by reloading
      state = AsyncValue.error(e, stackTrace);
      await loadOrders(); // Reload to get correct state
    }
  }

  /// Advance order to next status (for convenience)
  Future<void> advanceOrderStatus(String orderId) async {
    state.whenData((orders) {
      try {
        final order = orders.firstWhere((o) => o.id == orderId);
        if (order.canAdvance && order.nextStatus != null) {
          updateOrderStatus(orderId, order.nextStatus!);
        }
      } catch (e) {
        // Order not found
      }
    });
  }

  /// Refresh orders (pull-to-refresh)
  Future<void> refresh() async {
    // Show loading state during refresh
    state = const AsyncValue.loading();

    try {
      final orders = await _repository.refreshOrders();
      state = AsyncValue.data(orders);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Get orders by status
  List<Order> getOrdersByStatus(OrderStatus status) {
    return state.when(
      data: (orders) => orders.where((o) => o.status == status).toList(),
      loading: () => [],
      error: (_, __) => [],
    );
  }

  /// Search orders by customer name or order ID
  List<Order> searchOrders(String query) {
    if (query.isEmpty) {
      return state.value ?? [];
    }

    return state.when(
      data: (orders) {
        final lowerQuery = query.toLowerCase();
        return orders.where((order) {
          return order.customerName.toLowerCase().contains(lowerQuery) ||
              order.id.toLowerCase().contains(lowerQuery);
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );
  }
}
