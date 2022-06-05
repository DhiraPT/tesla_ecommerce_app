import 'package:flutter/material.dart';

class AccountAndSettingsAppBar extends StatelessWidget {
  const AccountAndSettingsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
		return const SliverAppBar(
			toolbarHeight: 80,
			pinned: false,
			elevation: 0,
			title: CircleAvatar(
        backgroundColor: Color(0xffE6E6E6),
        radius: 30,
        child: Icon(
          Icons.person,
          color: Color(0xffCCCCCC),
        ),
      ),
			titleSpacing: 15.0,
		);
	}
}