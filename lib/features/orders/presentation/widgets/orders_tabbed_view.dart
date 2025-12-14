import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/features/orders/domain/entities/order.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';
import 'package:pizza_panic/features/orders/presentation/screens/order_details_screen.dart';
import 'package:pizza_panic/features/orders/presentation/widgets/order_card.dart';

/// Tabbed view widget for orders organized by status
class OrdersTabbedView extends ConsumerStatefulWidget {
  final Map<OrderStatus, List<Order>> ordersByStatus;
  final Future<void> Function() onRefresh;

  const OrdersTabbedView({
    required this.ordersByStatus,
    required this.onRefresh,
    super.key,
  });

  @override
  ConsumerState<OrdersTabbedView> createState() => _OrdersTabbedViewState();
}

class _OrdersTabbedViewState extends ConsumerState<OrdersTabbedView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _renderTabBar(context),
        Expanded(
          child: _renderTabBarView(context),
        ),
      ],
    );
  }

  Widget _renderTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: Theme.of(context).colorScheme.onSurface,
        unselectedLabelColor: Theme.of(context)
            .colorScheme
            .onSurfaceVariant
            .withValues(alpha: 0.6),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: [
          _renderTab(
            context,
            OrderStatus.preparing,
            widget.ordersByStatus[OrderStatus.preparing] ?? [],
          ),
          _renderTab(
            context,
            OrderStatus.onTheWay,
            widget.ordersByStatus[OrderStatus.onTheWay] ?? [],
          ),
          _renderTab(
            context,
            OrderStatus.delivered,
            widget.ordersByStatus[OrderStatus.delivered] ?? [],
          ),
        ],
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: _getTabColor(_tabController.index),
              width: 3,
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderTab(
    BuildContext context,
    OrderStatus status,
    List<Order> orders,
  ) {
    final color = _getStatusColor(status);
    final isSelected = _tabController.index == status.index;

    return Tab(
      iconMargin: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isSelected ? 0.15 : 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getStatusIcon(status),
              size: 10,
              color: color,
            ),
          ),
          const SizedBox(width: 2),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStatusLabel(status),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${orders.length} ${orders.length == 1 ? 'order' : 'orders'}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderTabBarView(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: _renderOrdersList(
            context,
            OrderStatus.preparing,
            widget.ordersByStatus[OrderStatus.preparing] ?? [],
          ),
        ),
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: _renderOrdersList(
            context,
            OrderStatus.onTheWay,
            widget.ordersByStatus[OrderStatus.onTheWay] ?? [],
          ),
        ),
        RefreshIndicator(
          onRefresh: widget.onRefresh,
          child: _renderOrdersList(
            context,
            OrderStatus.delivered,
            widget.ordersByStatus[OrderStatus.delivered] ?? [],
          ),
        ),
      ],
    );
  }

  Widget _renderOrdersList(
    BuildContext context,
    OrderStatus status,
    List<Order> orders,
  ) {
    if (orders.isEmpty) {
      return _renderEmptyState(context, status);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: OrderCard(
            order: order,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => OrderDetailsScreen(orderId: order.id),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _renderEmptyState(BuildContext context, OrderStatus status) {
    final color = _getStatusColor(status);

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getStatusIcon(status),
                  size: 64,
                  color: color,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'No ${_getStatusLabel(status).toLowerCase()} orders',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _getEmptyMessage(status),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
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

  Color _getTabColor(int index) {
    switch (index) {
      case 0:
        return AppColors.preparing;
      case 1:
        return AppColors.onTheWay;
      case 2:
        return AppColors.delivered;
      default:
        return AppColors.preparing;
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

  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.onTheWay:
        return 'On the Way';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  String _getEmptyMessage(OrderStatus status) {
    switch (status) {
      case OrderStatus.preparing:
        return 'No orders are being prepared right now';
      case OrderStatus.onTheWay:
        return 'No orders are currently out for delivery';
      case OrderStatus.delivered:
        return 'No orders have been delivered yet';
    }
  }
}
