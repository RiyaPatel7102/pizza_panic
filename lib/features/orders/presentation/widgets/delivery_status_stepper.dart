import 'package:flutter/material.dart';
import 'package:pizza_panic/core/constants/app_colors.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/features/orders/domain/entities/order_status.dart';

/// Delivery status stepper widget
/// Shows visual progress of order delivery stages
class DeliveryStatusStepper extends StatelessWidget {
  const DeliveryStatusStepper({
    super.key,
    required this.currentStatus,
    this.animated = true,
  });

  final OrderStatus currentStatus;
  final bool animated;

  @override
  Widget build(BuildContext context) {
    final currentStep = currentStatus.stepIndex;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          // Title
          Text(
            'Delivery Progress',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Stepper
          Row(
            children: List.generate(4, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;
              final stepLabel = AppConstants.statusStepperLabels[index];

              return Expanded(
                child: _buildStep(
                  context,
                  index: index,
                  label: stepLabel,
                  isCompleted: isCompleted,
                  isCurrent: isCurrent,
                  isLast: index == 3,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(
    BuildContext context, {
    required int index,
    required String label,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine colors
    Color circleColor;
    Color lineColor;
    Color textColor;

    if (isCompleted) {
      circleColor = AppColors.success;
      lineColor = AppColors.success;
      textColor = theme.textTheme.bodyMedium!.color!;
    } else if (isCurrent) {
      circleColor = AppColors.primaryColor;
      lineColor = colorScheme.surfaceContainerHighest;
      textColor = AppColors.primaryColor;
    } else {
      circleColor = colorScheme.surfaceContainerHighest;
      lineColor = colorScheme.surfaceContainerHighest;
      textColor = colorScheme.onSurfaceVariant;
    }

    return Column(
      children: [
        // Step indicator row
        Row(
          children: [
            // Circle indicator
            AnimatedContainer(
              duration: animated ? AppConstants.animationMedium : Duration.zero,
              width: isCurrent ? 40 : 32,
              height: isCurrent ? 40 : 32,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: circleColor.withValues(alpha: 0.4),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: AppConstants.animationFast,
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          key: ValueKey('check'),
                        )
                      : Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          key: ValueKey('number-$index'),
                        ),
                ),
              ),
            ),

            // Connecting line (except for last step)
            if (!isLast)
              Expanded(
                child: AnimatedContainer(
                  duration:
                      animated ? AppConstants.animationMedium : Duration.zero,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: lineColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
          ],
        ),

        const SizedBox(height: AppSpacing.md),

        // Label
        AnimatedDefaultTextStyle(
          duration: animated ? AppConstants.animationMedium : Duration.zero,
          style: theme.textTheme.bodySmall!.copyWith(
            color: textColor,
            fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
