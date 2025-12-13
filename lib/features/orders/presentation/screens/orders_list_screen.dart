import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/presentation/providers/orders_providers.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/empty_orders_view.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_card.dart';
import 'package:pizza_panic/shared/widgets/error_view.dart';
import 'package:pizza_panic/shared/widgets/loading_indicator.dart';

/// Orders list screen
/// Main screen showing all orders grouped by status
class OrdersListScreen extends ConsumerWidget {
  const OrdersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersNotifierProvider);
    final ordersByStatus = ref.watch(ordersByStatusProvider);

    return Scaffold(
      appBar: _renderAppBar(context, ordersAsync),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(ordersNotifierProvider.notifier).refresh();
        },
        child: ordersAsync.when(
          data: (orders) {
            if (orders.isEmpty) {
              return const EmptyOrdersView();
            }
            return _renderOrdersList(context, ref, ordersByStatus);
          },
          loading: () => const LoadingIndicator(message: 'Loading orders...'),
          error: (error, _) => ErrorView(
            message: error.toString(),
            onRetry: () {
              ref.read(ordersNotifierProvider.notifier).loadOrders();
            },
          ),
        ),
      ),
    );
  }

  AppBar _renderAppBar(BuildContext context, AsyncValue<dynamic> ordersAsync) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppConstants.appName),
          Text(
            AppConstants.appTagline,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        // Order count badge
        ordersAsync.whenData((orders) {
              return Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Chip(
                    label: Text(
                      '${orders.length} Orders',
                      style: const TextStyle(fontSize: 12),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
              );
            }).value ??
            const SizedBox.shrink(),
      ],
    );
  }

  Widget _renderOrdersList(
    BuildContext context,
    WidgetRef ref,
    Map<OrderStatus, List<Order>> ordersByStatus,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      children: [
        // Preparing section
        _renderStatusSection(
          context,
          ref,
          OrderStatus.preparing,
          ordersByStatus[OrderStatus.preparing] ?? [],
        ),

        const SizedBox(height: 16),

        // On the Way section
        _renderStatusSection(
          context,
          ref,
          OrderStatus.onTheWay,
          ordersByStatus[OrderStatus.onTheWay] ?? [],
        ),

        const SizedBox(height: 16),

        // Delivered section
        _renderStatusSection(
          context,
          ref,
          OrderStatus.delivered,
          ordersByStatus[OrderStatus.delivered] ?? [],
        ),
      ],
    );
  }

  Widget _renderStatusSection(
    BuildContext context,
    WidgetRef ref,
    OrderStatus status,
    List<Order> orders,
  ) {
    if (orders.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                status.displayName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${orders.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Order cards
        ...orders.map((order) {
          return OrderCard(
            order: order,
            onTap: () {
              // TODO: Navigate to order details (Branch 8)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order details coming soon: ${order.id}'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
