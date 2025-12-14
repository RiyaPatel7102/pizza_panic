import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/core/theme/theme_provider.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/presentation/providers/orders_providers.dart';
import 'package:pizza_panic/features/orders/presentation/screens/order_details_screen.dart';
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
      centerTitle: false,
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
        // Theme mode switch
        Consumer(
          builder: (context, ref, child) {
            final themeMode = ref.watch(themeModeProvider);
            final isDarkMode = themeMode == ThemeMode.dark;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _renderOrdersList(
    BuildContext context,
    WidgetRef ref,
    Map<OrderStatus, List<Order>> ordersByStatus,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        // Preparing section
        _renderStatusSection(
          context,
          ref,
          OrderStatus.preparing,
          ordersByStatus[OrderStatus.preparing] ?? [],
        ),

        const SizedBox(height: AppSpacing.md),

        // On the Way section
        _renderStatusSection(
          context,
          ref,
          OrderStatus.onTheWay,
          ordersByStatus[OrderStatus.onTheWay] ?? [],
        ),

        const SizedBox(height: AppSpacing.md),

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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            children: [
              Text(
                status.displayName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: AppRadius.radiusMd,
                ),
                child: Text(
                  '${orders.length}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Order cards
        ...orders.map((order) {
          return OrderCard(
            order: order,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => OrderDetailsScreen(orderId: order.id),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
