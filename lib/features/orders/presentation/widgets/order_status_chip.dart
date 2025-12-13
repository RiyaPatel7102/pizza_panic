import 'package:flutter/material.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';

/// Status chip widget
/// Displays order status with appropriate color
class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({
    super.key,
    required this.status,
    this.showIcon = true,
  });

  final OrderStatus status;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    final color = _getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.radiusXl,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(_getStatusIcon(status), size: 14, color: color),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            status.displayName.substring(2), // Remove emoji
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.preparing:
        return AppColors.preparing;
      case OrderStatus.onTheWay:
        return AppColors.onTheWay;
      case OrderStatus.delivered:
        return AppColors.delivered;
    }
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
