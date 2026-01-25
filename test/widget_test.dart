import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test: Environment is ready', (WidgetTester tester) async {
    // Build a simple app to verify the test runner works
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('Smoke Test')),
      ),
    ));

    expect(find.text('Smoke Test'), findsOneWidget);
  });
}
