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

final expenses = <String>[];
var typingExpense = "";

class _MyHomePageState extends State<MyHomePage> {
	TextEditingController submitController = TextEditingController();

	void addExpense() {
		showDialog(
			context: context,
			builder: (context) {
				return AlertDialog(
					title: const Text("Add Expense"),
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
									expenses.add(typingExpense);
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
					separatorBuilder: (x, y) => VerticalDivider(indent: 2.0, width: 2.0, thickness: 2.0),
					itemBuilder: (context, index) {
						return Text(
							expenses[index],
							style: theme.textTheme.headline6,
						);
					},
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: addExpense,
				tooltip: "Increment",
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
