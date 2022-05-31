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
				primarySwatch: Colors.purple,
			),

			initialRoute: "/",
			routes: {
				"/": (context) => const MyHomePage(title: "Home"),
			}
		);
	}
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({Key? key, required this.title}) : super(key: key);
	final String title;

	@override
	State<MyHomePage> createState() => _MyHomePageState();
}

class Expense {
	var kind = Icons.house;
	var name = "";
	var perMonth = 0;

	Expense(this.name);
}

final expenses = <Expense>[];
var typingExpense = "";

class _MyHomePageState extends State<MyHomePage> {
	TextEditingController submitController = TextEditingController();

	void modifyExpense(int? index) {
		showDialog(
			context: context,
			builder: (context) {
				return AlertDialog(
					title: Text("${index != null ? "Modify" : "Add"} Expense"),
					content: TextField(
						onChanged: (val) {
							setState(() => typingExpense = val);
						},
						controller: submitController,
						decoration: const InputDecoration(hintText: "Groceries"),
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
								setState(() {
									if (index != null) {
										expenses[index].name = typingExpense;
									} else {
										expenses.add(Expense(typingExpense));
									}
								});
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
			),

			body: Center(
				child: ListView.separated (
					itemCount: expenses.length,
					separatorBuilder: (x, y) => const Divider(),
					itemBuilder: (context, index) =>
						ListTile(
							title: Text(expenses[index].name),
							leading: IconButton(
								icon: Icon(expenses[index].kind),
								onPressed: () => editExpenseIcon(index)
							),
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
							),
							onTap: () => setState(() => expenses.removeAt(index)),
						)
					,
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
						DrawerHeader(
							decoration: BoxDecoration(color: theme.drawerTheme.backgroundColor),
							child: Text(
								"Settings",
								style: Theme.of(context).textTheme.displaySmall
							),
						),
						ListTile(
							title: const Text("Clear Expenses"),
							onTap: () => setState(() => expenses.clear()),
						),
					]
				),
			)
		);
	}
}
