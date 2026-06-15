import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_ai_code_agent/main.dart';

void main() {
  testWidgets('Dynamic issue workflow updates step status', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Dynamic Issue'), findsOneWidget);
    expect(find.text('#2 Add dynamic issue support'), findsOneWidget);
    expect(find.text('Status: Open'), findsOneWidget);
    expect(find.text('Create issue'), findsOneWidget);
    expect(find.text('Keep issue open'), findsOneWidget);
    expect(find.text('Validate updates'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.task_alt));
    await tester.pump();

    expect(find.text('Status: In progress'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.task_alt));
    await tester.pump();

    expect(find.text('Status: Ready to close'), findsOneWidget);
    expect(find.text('Ready'), findsOneWidget);
  });
}
