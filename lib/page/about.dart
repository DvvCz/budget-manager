import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
	const AboutPage({Key? key}) : super(key: key);

	@override
	State<AboutPage> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
	@override
	Widget build(BuildContext context) {
		final theme = Theme.of(context);
		return Scaffold(
			appBar: AppBar(),
			body: Center(
				child: Text(
					"This is an app to help you manage your budget.",
					style: theme.primaryTextTheme.titleLarge
				)
			)
		);
	}
}