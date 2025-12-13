import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_status_chip.dart';

/// Order card widget
/// Displays order summary in a card
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  final Order order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.radiusMd,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pizza image
              _renderPizzaImage(context),
              const SizedBox(width: AppSpacing.md),
              // Order details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _renderHeader(context),
                    const SizedBox(height: AppSpacing.md),
                    _renderOrderInfo(context),
                    const SizedBox(height: AppSpacing.md),
                    _renderFooter(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderPizzaImage(BuildContext context) {
    // Show placeholder if no pizzas or no image URL
    if (order.pizzas.isEmpty || order.pizzas.first.imageUrl == null) {
      return Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: AppRadius.radiusMd,
        ),
        child: const Icon(
          Icons.local_pizza,
          color: AppColors.primaryColor,
          size: 40,
        ),
      );
    }

    final imageUrl = order.pizzas.first.imageUrl!;

    return ClipRRect(
      borderRadius: AppRadius.radiusMd,
      child: Image.network(
        imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.radiusMd,
            ),
            child: const Icon(
              Icons.local_pizza,
              color: AppColors.primaryColor,
              size: 40,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: AppRadius.radiusMd,
            ),
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      ),
    );
  }

  Widget _renderHeader(BuildContext context) {
    return Row(
      children: [
        // Order ID
        Text(
          order.id,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const Spacer(),
        // Status chip
        OrderStatusChip(status: order.status),
      ],
    );
  }

  Widget _renderOrderInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer name
        Row(
          children: [
            Icon(Icons.person, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                order.customerName,
                style: textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        // Pizzas
        Row(
          children: [
            Icon(Icons.local_pizza, color: colorScheme.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                order.pizzaNamesDisplay,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _renderFooter(BuildContext context) {
    final orderTime = DateFormat('hh:mm a').format(order.orderTime);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        // Order time
        Icon(Icons.access_time, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.xs),
        Text(
          orderTime,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        // Total amount
        Text(
          order.formattedTotal,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
