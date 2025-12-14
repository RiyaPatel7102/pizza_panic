import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pizza_panic/core/constants/app_constants.dart';
import 'package:pizza_panic/core/theme/app_theme.dart';
import 'package:pizza_panic/core/theme/theme_provider.dart';
import 'package:pizza_panic/features/orders/presentation/screens/orders_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Hide system navigation bar
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersive,
  );

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
    final isDarkMode = themeMode == ThemeMode.dark;

    // Configure system UI overlay style based on theme
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkMode ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );

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
