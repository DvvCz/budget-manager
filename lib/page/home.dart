import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class HomePage extends StatefulWidget {
	const HomePage({Key? key, required this.title}) : super(key: key);
	final String title;

	@override
	State<HomePage> createState() => HomePageState();
}

class Expense {
	var kind = Icons.house;
	var name = "";
	var perMonth = 0;

	Expense(this.name, {this.perMonth = 0});
}

class HomePageState extends State<HomePage> {
	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		return Scaffold(
			appBar: AppBar(),
			body: Center(
				child: Wrap(
					direction: Axis.vertical,
					children: [
						Text(
							widget.title,
							style: theme.primaryTextTheme.displayLarge,
						),
						Wrap(
							children: [
								TextButton(
									child: const Text("Enter"),
									onPressed: () => Navigator.pushNamed(context, "/expenses")
								),
								TextButton(
									child: const Text("About"),
									onPressed: () => Navigator.pushNamed(context, "/about")
								)
							]
						)
					]
				)
			)
		);
	}
}
