import "package:flutter/material.dart";

class ResultsRoute extends StatelessWidget {
	const ResultsRoute({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: "Budget Manager",
			theme: ThemeData(
				primarySwatch: Colors.purple,
			),

			home: const ResultsPage(title: "Results"),
		);
	}
}

class ResultsPage extends StatefulWidget {
	const ResultsPage({Key? key, required this.title}) : super(key: key);
	final String title;

	@override
	State<ResultsPage> createState() => ResultsState();
}

class ResultsState extends State<ResultsPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
				automaticallyImplyLeading: true,
			),
			body: Center(
				child: Wrap(
					children: [
						IconButton(
							icon: const Icon(Icons.home),
							onPressed: () {
								Navigator.popAndPushNamed(context, "/");
							}
						)
					],
				),
			),
		);
	}
}