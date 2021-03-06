import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpensesPage extends StatefulWidget {
	const ExpensesPage({super.key, required this.title});
	final String title;

	@override
	State<ExpensesPage> createState() => ExpensesPageState();
}

class Expense {
	var kind = Icons.house;
	var name = "";
	var perMonth = 0;

	Expense(this.name, {this.perMonth = 0});
}

final expenses = <Expense>[];

class ExpensesPageState extends State<ExpensesPage> {
	TextEditingController submitController = TextEditingController();
	TextEditingController submitMoneyController = TextEditingController();

	void modifyExpense(int? index) {
		showDialog(
			context: context,
			builder: (context) {
				bool exists = index != null;
				Expense expense = exists ? expenses[index] : Expense(
					"Groceries",
					perMonth: 0,
				);

				return AlertDialog(
					title: Text("${exists ? "Modify" : "Add"} Expense"),
					content: Wrap(
						children: [
							TextField(
								inputFormatters: [
									FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9 ]"))
								],
								controller: submitController,
								decoration: InputDecoration(
									hintText: expense.name
								),
							),
							TextField(
								inputFormatters: [
									FilteringTextInputFormatter.allow(RegExp("[0-9]"))
								],
								controller: submitMoneyController,
								decoration: InputDecoration(
									hintText: expense.perMonth.toString(),
									prefix: const Text("\$"),
								),
							)
						]
					),
					actions: [
						TextButton(
							style: TextButton.styleFrom(
								primary: Colors.white,
								backgroundColor: Colors.red,
							),
							onPressed: () {
								Navigator.of(context).pop();
							},
							child: const Text("CANCEL"),
						),
						TextButton(
							style: TextButton.styleFrom(
								primary: Colors.white,
								backgroundColor: Colors.green,
							),
							onPressed: () {
								int parsed = int.tryParse(submitMoneyController.text) ?? 0;
								if (parsed == 0) {
									Navigator.of(context).pop();
									showDialog(
										context: context,
										builder: (context) => const AlertDialog(
											title: Text("Invalid Amount"),
											content: Text("Please enter a valid amount")
										)
									);
								} else {
									setState(() {
										expense.name = submitController.text;
										expense.perMonth = parsed;

										if (!exists) expenses.add(expense);
									});
								}
								Navigator.of(context).pop();
							},
							child: const Text("OK"),
						),
					]
				);
			},
		);
	}

	void editExpenseIcon(int index) {
		showDialog(
			context: context,
			builder: (context) {
				return AlertDialog(
					actionsOverflowDirection: VerticalDirection.down,
					title: const Text("Pick Expense Icon"),
					actions: [
						for (var icon in [Icons.house, Icons.face, Icons.emergency, Icons.luggage, Icons.directions_car, Icons.school, Icons.work]) IconButton(
							icon: Icon(icon),
							onPressed: () {
								setState(() => expenses[index].kind = icon);
								Navigator.pop(context);
							}
						)
					]
				);
			},
		);
	}

	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				centerTitle: true,
				actions: [
					Padding(
						padding: const EdgeInsets.only(right: 20.0),
						child: IconButton(
							icon: const Icon(Icons.list_alt),
							onPressed: () => Navigator.pushNamed(context, "/dashboard"),
						)
					)
				],
			),

			body: Center(
				child: ListView.separated (
					itemCount: expenses.length,
					separatorBuilder: (x, y) => const Divider(),
					itemBuilder: (context, index) {
						final expense = expenses[index];
						return ListTile(
							title: Text(expense.name),
							leading: IconButton(
								icon: Icon(expenses[index].kind),
								onPressed: () => editExpenseIcon(index)
							),
							subtitle: Text("\$${expense.perMonth}"),
							trailing: Wrap(
								children: [
									IconButton(
										icon: const Icon(Icons.edit),
										onPressed: () => modifyExpense(index),
									),
									IconButton(
										icon: const Icon(Icons.delete),
										onPressed: () => setState(() => expenses.removeAt(index)),
									),
								],
							)
						);
					}
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () => modifyExpense(null),
				tooltip: "Add Expense",
				child: const Icon(Icons.add),
			),
			drawer: Drawer(
				child: ListView(
					padding: EdgeInsets.zero,
					children: [
						SizedBox(
							height: 120,
							child: DrawerHeader(
								decoration: BoxDecoration(color: theme.drawerTheme.backgroundColor),
								child: Text(
									"Menu",
									style: theme.textTheme.displayMedium
								),
							),
						),
						ListTile(
							title: const Text("Clear Expenses"),
							onTap: () => setState(() => expenses.clear()),
						),
						ListTile(
							title: const Text("Go Home"),
							onTap: () => Navigator.of(context).popUntil(ModalRoute.withName("/")),
						),
					]
				),
			)
		);
	}
}