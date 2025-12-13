import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_status_chip.dart';

/// Order card widget
/// Displays order summary in a card
class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderHeader(context),
              const SizedBox(height: 12),
              _renderOrderInfo(context),
              const SizedBox(height: 12),
              _renderFooter(context),
            ],
          ),
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Customer name
        Row(
          children: [
            const Icon(Icons.person, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.customerName,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Pizzas
        Row(
          children: [
            const Icon(Icons.local_pizza, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.pizzaNamesDisplay,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
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

    return Row(
      children: [
        // Order time
        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          orderTime,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        const Spacer(),
        // Total amount
        Text(
          order.formattedTotal,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
        ),
      ],
    );
  }
}
