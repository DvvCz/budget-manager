import 'package:budget_manager/page/expenses.dart';
import "package:flutter/material.dart";

class DashboardPage extends StatefulWidget {
	const DashboardPage({Key? key, required this.title}) : super(key: key);
	final String title;

	@override
	State<DashboardPage> createState() => DashboardState();
}

double income = 10000;

class DashboardState extends State<DashboardPage> {
	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);

		double totalExpenses = 0;
		for (var expense in expenses) {
			totalExpenses += expense.perMonth;
		}

		final gridItems = <Widget>[
			Stack(
				fit: StackFit.expand,
				children: [
					Text(
						"Total Expenses",
						style: theme.textTheme.displaySmall
					),
					Center(
						child: Text(
							totalExpenses.toString(),
							style: theme.textTheme.displayLarge
						),
					),
					CircularProgressIndicator(
						value: income / totalExpenses,
						valueColor: const AlwaysStoppedAnimation(Colors.red),
					)
				]
			),

			Wrap(
				children: [
					TextField(
						decoration: const InputDecoration(label: Text("Income")),
						style: theme.textTheme.displayMedium,
						onChanged: (inc) => setState(() => income = double.tryParse(inc) ?? income),
					)
				]
			),

			const Text("WIP"),
			const Text("WIP"),
		];

		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				automaticallyImplyLeading: true,
			),
			body: GridView.builder (
				gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent (
					maxCrossAxisExtent: 700,
					mainAxisExtent: 400
				),
				itemCount: 4,
				itemBuilder: (context, i) => SizedBox(
					height: 380,
					width: 380,
					child: gridItems[i]
				)
			)
		);
	}
}