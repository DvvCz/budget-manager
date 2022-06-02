import 'package:budget_manager/page/about.dart';
import 'package:budget_manager/page/dashboard.dart';
import 'package:budget_manager/page/expenses.dart';
import 'package:budget_manager/page/home.dart';
import "package:flutter/material.dart";

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "Budget Manager",
			theme: ThemeData(
				brightness: Brightness.dark,
				primarySwatch: Colors.purple,
			),

			initialRoute: "/",
			routes: {
				"/": (context) => const HomePage(title: "Home"),
				"/about": (context) => const AboutPage(),
				"/expenses": (context) => const ExpensesPage(title: "Expenses"),
				"/dashboard": (context) => const DashboardPage(title: "Dashboard")
			}
		);
	}
}