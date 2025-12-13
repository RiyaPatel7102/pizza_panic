import 'package:flutter_test/flutter_test.dart';
import 'package:pizza_panic/main.dart';

void main() {
  testWidgets('Pizza Panic app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PizzaPanicApp());

    // Verify that our setup message appears.
    expect(find.text('Pizza Panic - Setup Complete! 🍕'), findsOneWidget);
  });
}
