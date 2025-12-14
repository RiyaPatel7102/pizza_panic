import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/core/theme/theme_provider.dart';
import 'package:pizza_panic/features/orders/presentation/providers/orders_providers.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/empty_orders_view.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/orders_tabbed_view.dart';
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
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await ref.read(ordersNotifierProvider.notifier).refresh();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 200),
                  EmptyOrdersView(),
                ],
              ),
            );
          }
          return OrdersTabbedView(
            ordersByStatus: ordersByStatus,
            onRefresh: () async {
              await ref.read(ordersNotifierProvider.notifier).refresh();
            },
          );
        },
        loading: () => const LoadingIndicator(message: 'Loading orders...'),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () {
            ref.read(ordersNotifierProvider.notifier).loadOrders();
          },
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
}
