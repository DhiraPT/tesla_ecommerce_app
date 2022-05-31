import 'package:flutter/material.dart';

class ShoppingCartAppBar extends StatelessWidget {
	const ShoppingCartAppBar({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return SliverAppBar(
			toolbarHeight: 80,
			pinned: true,
			elevation: 0,
			title: Text('My Shopping Cart', style: Theme.of(context).textTheme.headlineMedium),
			titleSpacing: 15.0,
		);
	}
}
