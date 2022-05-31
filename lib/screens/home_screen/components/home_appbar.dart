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
			toolbarHeight: 80,
			pinned: true,
			elevation: 0,
			leading: _isSearching ? const BackButton() : null,
			title: const Padding(
				padding: EdgeInsets.only(top: 4),
				child: HomeSearchBox(),
			),
			titleSpacing: 15.0,
			actions: [
				Padding(
					padding: const EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 10.0),
					child: TextButton(
						onPressed: () {
							Navigator.push(
								context,
								MaterialPageRoute(builder: (context) => const CameraScreen()),
							);
						},
						style: TextButton.styleFrom(
							primary: const Color.fromRGBO(162, 162, 162, 1.0),
							backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
							padding: EdgeInsets.zero,
							minimumSize: const Size(54, 30),
							tapTargetSize: MaterialTapTargetSize.shrinkWrap,
						),
						child: const Icon(
							Icons.camera_alt_outlined,
							color: Colors.black,
						),
					)
				)
			],
			bottom: PreferredSize(
				preferredSize: const Size.fromHeight(40.0),
				child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 7.0),
                  ButtonsTabBar(
                    height: 40.0,
                    backgroundColor: Colors.black,
                    unselectedBackgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
                    labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.white),
                    unselectedLabelStyle: Theme.of(context).textTheme.subtitle2,
                    radius: 10.0,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                    buttonMargin: const EdgeInsets.symmetric(horizontal: 8.0),
                    tabs: tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                  const SizedBox(width: 7.0),
                ]
              )
				    ),
            const SizedBox(height: 5.0),
          ]
        )
			)
		);
	}
}
