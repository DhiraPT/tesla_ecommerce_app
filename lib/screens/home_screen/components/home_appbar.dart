import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/components/home_searchbox.dart';
import 'package:tesla_ecommerce_app/screens/camera_screen/camera_screen.dart';

class HomeAppBar extends StatelessWidget {
	final List<String> tabs;
	final bool _isSearching = false;
	final String searchQuery = "Search query";
	const HomeAppBar({Key? key, required this.tabs}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return SliverAppBar(
			toolbarHeight: 90,
			pinned: true,
			elevation: 0,
			leading: _isSearching ? const BackButton() : null,
			title: const HomeSearchBox(),
			titleSpacing: 20.0,
			actions: [
				Padding(
					padding: const EdgeInsets.fromLTRB(0.0, 21.0, 20.0, 21.0),
					child: TextButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => const CameraScreen()),
							);
						},
						style: TextButton.styleFrom(
							primary: const Color.fromRGBO(162, 162, 162, 1.0),
							backgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
							padding: EdgeInsets.zero,
							minimumSize: const Size(54, 30),
						),
						child: const Icon(
							Icons.camera_alt_outlined,
							color: Colors.black
						),
					)
				)
			],
			bottom: PreferredSize(
				preferredSize: const Size.fromHeight(46.0),
				child: SingleChildScrollView(
					scrollDirection: Axis.horizontal,
					child: Row(
						children: [
							const SizedBox(width: 10.0),
							ButtonsTabBar(
								backgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
								unselectedBackgroundColor: Colors.white,
								labelStyle: Theme.of(context).textTheme.subtitle2,
								unselectedLabelStyle: Theme.of(context).textTheme.subtitle2,
								radius: 10.0,
								contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
								buttonMargin: const EdgeInsets.symmetric(horizontal: 10.0),
								tabs: tabs.map((String name) => Tab(text: name)).toList(),
							),
							const SizedBox(width: 10.0),
						]
					)
				)
			)
		);
	}
}
