import 'package:budget_manager/page/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:budget_manager/main.dart';

void main() {
	testWidgets("Expenses page tests", (WidgetTester tester) async {
		// Build our app and trigger a frame.
		await tester.pumpWidget(const MyApp());

		expect(find.widgetWithText(TextButton, "Enter"), findsOneWidget);
		await tester.tap(find.widgetWithText(TextButton, "Enter"));
		await tester.pump();

		// Tap the '+' icon and trigger a frame.
		await tester.tap(find.byIcon(Icons.add));
		await tester.pump();

		await tester.enterText(find.byType(TextField), "School");
		await tester.pump();

		await tester.tap(find.widgetWithText(TextButton, "OK"));
		await tester.pump();


		// Menu should've disappeared.
		expect(find.widgetWithText(TextButton, "OK"), findsNothing);

		// Expense should've been added to the list.
		print(expenses.length);
	});
}
