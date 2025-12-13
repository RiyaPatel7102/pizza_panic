import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/core/theme/app_theme.dart';
import 'package:pizza_panic/core/theme/theme_provider.dart';
import 'package:pizza_panic/features/orders/presentation/screens/orders_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PizzaPanicApp(),
    ),
  );
}

class PizzaPanicApp extends ConsumerWidget {
  const PizzaPanicApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const OrdersListScreen(),
    );
  }
}
