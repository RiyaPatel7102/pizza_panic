import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/core/theme/app_theme.dart';
import 'package:pizza_panic/features/orders/presentation/screens/orders_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PizzaPanicApp(),
    ),
  );
}

class PizzaPanicApp extends StatelessWidget {
  const PizzaPanicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const OrdersListScreen(),
    );
  }
}
