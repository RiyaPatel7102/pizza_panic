import 'package:flutter/material.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_status_chip.dart';

/// Card widget displaying order summary information
class OrderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;

  const OrderCard({
    required this.order,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: isDarkMode ? 0.3 : 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(
          color: isDarkMode
              ? Colors.white.withValues(alpha: 0.12)
              : Colors.black.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large pizza image at the top
            _renderPizzaImage(context),
            // Content below image
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _renderHeader(context),
                  const SizedBox(height: AppSpacing.xs),
                  _renderSubtitle(context),
                  const SizedBox(height: AppSpacing.xs),
                  _renderInfoBadges(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderPizzaImage(BuildContext context) {
    final firstPizza = order.pizzas.isNotEmpty ? order.pizzas.first : null;
    final imageUrl = firstPizza?.imageUrl;

    return Stack(
      children: [
        // Pizza Image
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.lg),
              topRight: Radius.circular(AppRadius.lg),
            ),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.lg),
              topRight: Radius.circular(AppRadius.lg),
            ),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _renderPlaceholderImage(context);
                    },
                  )
                : _renderPlaceholderImage(context),
          ),
        ),
        // Status chip overlay at top-right with background
        Positioned(
          top: AppSpacing.sm,
          right: AppSpacing.sm,
          child: Container(
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(AppRadius.circular),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: OrderStatusChip(status: order.status),
          ),
        ),
      ],
    );
  }

  Widget _renderPlaceholderImage(BuildContext context) {
    return Center(
      child: Icon(
        Icons.local_pizza,
        size: 50,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _renderHeader(BuildContext context) {
    return Text(
      order.id,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderSubtitle(BuildContext context) {
    final firstPizza = order.pizzas.isNotEmpty ? order.pizzas.first : null;
    final pizzaName = firstPizza?.name ?? 'Pizza Order';

    // Show pizza names if multiple
    final subtitle = order.pizzas.length > 1
        ? '$pizzaName and ${order.pizzas.length - 1} more'
        : pizzaName;

    return Text(
      subtitle,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _renderInfoBadges(BuildContext context) {
    final totalPizzas = order.pizzas.fold<int>(
      0,
      (int sum, pizza) => sum + pizza.quantity,
    );

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [
        _renderBadge(
          context,
          icon: Icons.person,
          label: order.customerName,
          color: Theme.of(context).colorScheme.primary,
        ),
        _renderBadge(
          context,
          icon: Icons.local_pizza,
          label: '$totalPizzas ${totalPizzas == 1 ? 'pizza' : 'pizzas'}',
          color: Theme.of(context).colorScheme.secondary,
        ),
        _renderBadge(
          context,
          icon: Icons.location_on,
          label: _getTruncatedAddress(),
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }

  Widget _renderBadge(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.circular),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _getTruncatedAddress() {
    final address = order.customerAddress;
    if (address.length <= 50) return address;
    return '${address.substring(0, 50)}...';
  }
}
