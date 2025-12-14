import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/presentation/providers/orders_providers.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/delivery_status_stepper.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_status_chip.dart';
import 'package:pizza_panic/shared/extensions/datetime_ext.dart';
import 'package:pizza_panic/shared/widgets/error_view.dart';
import 'package:pizza_panic/shared/widgets/loading_indicator.dart';

/// Order details screen
/// Shows full order information with status stepper and update button
class OrderDetailsScreen extends ConsumerWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderDetailsProvider(orderId));

    return Scaffold(
      body: orderAsync.when(
        data: (order) {
          if (order == null) {
            return const ErrorView(message: 'Order not found');
          }

          return CustomScrollView(
            slivers: [
              // Hero Pizza Image with gradient overlay
              _renderHeroImage(context, order),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Stepper
                    DeliveryStatusStepper(currentStatus: order.status),

                    const Divider(height: 32),

                    // Order Information
                    _renderSection(
                      context,
                      title: 'Order Information',
                      child: _renderOrderInfo(context, order),
                    ),

                    const Divider(height: 32),

                    // Customer Information
                    _renderSection(
                      context,
                      title: 'Customer Details',
                      child: _renderCustomerInfo(context, order),
                    ),

                    const Divider(height: 32),

                    // Pizzas
                    _renderSection(
                      context,
                      title: 'Order Items',
                      child: _renderPizzas(context, order),
                    ),

                    // Special Instructions
                    if (order.hasSpecialInstructions) ...[
                      const Divider(height: 32),
                      _renderSection(
                        context,
                        title: 'Special Instructions',
                        child: _renderSpecialInstructions(context, order),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // Update Status Button
                    if (order.canAdvance)
                      _renderUpdateButton(context, ref, order),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const LoadingIndicator(message: 'Loading order...'),
        error: (error, _) => ErrorView(message: error.toString()),
      ),
    );
  }

  Widget _renderHeroImage(BuildContext context, Order order) {
    final pizza = order.pizzas.isNotEmpty ? order.pizzas.first : null;
    final imageUrl = pizza?.imageUrl;

    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Pizza Image
            if (imageUrl != null)
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Icon(
                      Icons.local_pizza,
                      size: 120,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            else
              Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(
                  Icons.local_pizza,
                  size: 120,
                  color: AppColors.primaryColor,
                ),
              ),

            // Gradient overlay (dark at bottom for text readability)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),

            // Pizza name and quantity controls
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pizza name
                  if (pizza != null)
                    Text(
                      pizza.name,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }

  Widget _renderOrderInfo(BuildContext context, Order order) {
    return Column(
      children: [
        _renderInfoRow(
          context,
          icon: Icons.receipt,
          label: 'Order ID',
          value: order.id,
        ),
        const SizedBox(height: AppSpacing.md),
        _renderInfoRow(
          context,
          icon: Icons.schedule,
          label: 'Order Time',
          value: order.orderTime.formatted,
        ),
        const SizedBox(height: AppSpacing.md),
        _renderInfoRow(
          context,
          icon: Icons.access_time,
          label: 'Estimated Delivery',
          value: order.estimatedDeliveryTime.timeFormatted,
        ),
        if (order.deliveryTime != null) ...[
          const SizedBox(height: AppSpacing.md),
          _renderInfoRow(
            context,
            icon: Icons.check_circle,
            label: 'Delivered At',
            value: order.deliveryTime!.formatted,
            valueColor: AppColors.success,
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        _renderInfoRow(
          context,
          icon: Icons.circle,
          label: 'Status',
          value: '',
          trailing: OrderStatusChip(status: order.status),
        ),
      ],
    );
  }

  Widget _renderCustomerInfo(BuildContext context, Order order) {
    return Column(
      children: [
        _renderInfoRow(
          context,
          icon: Icons.person,
          label: 'Name',
          value: order.customerName,
        ),
        const SizedBox(height: AppSpacing.md),
        _renderInfoRow(
          context,
          icon: Icons.phone,
          label: 'Phone',
          value: order.customerPhone,
        ),
        const SizedBox(height: AppSpacing.md),
        _renderInfoRow(
          context,
          icon: Icons.location_on,
          label: 'Address',
          value: order.customerAddress,
        ),
      ],
    );
  }

  Widget _renderPizzas(BuildContext context, Order order) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: order.pizzas
          .map<Widget>((pizza) {
            return Card(
              margin: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pizza image
                  if (pizza.imageUrl != null)
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.md),
                      ),
                      child: Image.network(
                        pizza.imageUrl!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: colorScheme.surfaceContainerHighest,
                            child: const Icon(
                              Icons.local_pizza,
                              color: AppColors.primaryColor,
                              size: 80,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: double.infinity,
                            height: 200,
                            color: colorScheme.surfaceContainerHighest,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_pizza,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                pizza.name,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              pizza.formattedPrice,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Size: ${pizza.sizeDisplay} | Qty: ${pizza.quantity}',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Toppings: ${pizza.toppingsDisplay}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })
          .toList()
          .cast<Widget>()
        ..add(
          // Total row
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  order.formattedTotal,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _renderSpecialInstructions(BuildContext context, Order order) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: AppRadius.radiusMd,
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              order.specialInstructions!,
              style: textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
    Widget? trailing,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (value.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _renderUpdateButton(BuildContext context, WidgetRef ref, Order order) {
    final nextStatus = order.nextStatus!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () async {
            // Show confirmation dialog
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Update Order Status'),
                content: Text(
                  'Mark this order as "${nextStatus.displayName}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            );

            if (confirmed == true) {
              // Update status
              await ref
                  .read(ordersNotifierProvider.notifier)
                  .updateOrderStatus(order.id, nextStatus);

              // Refresh the order details to update the stepper
              ref.invalidate(orderDetailsProvider(orderId));

              // Show success message
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Order status updated to ${nextStatus.displayName.substring(2)}!',
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                  ),
                );

                // Go back if delivered
                if (nextStatus == OrderStatus.delivered) {
                  // Delay to show the snackbar before navigating back
                  await Future<void>.delayed(const Duration(milliseconds: 500));
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              }
            }
          },
          icon: Icon(_getStatusIcon(nextStatus)),
          label: Text('Mark as ${nextStatus.displayName.substring(2)}'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          ),
        ),
      ),
    );
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.preparing:
        return Icons.restaurant_menu;
      case OrderStatus.onTheWay:
        return Icons.delivery_dining;
      case OrderStatus.delivered:
        return Icons.check_circle;
    }
  }
}
