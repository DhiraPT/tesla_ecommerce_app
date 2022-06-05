import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/account_and_settings_screen/components/account_and_settings_appbar.dart';
import 'package:tesla_ecommerce_app/screens/account_and_settings_screen/components/account_and_settings_list_view.dart';

class AccountAndSettingsScreen extends StatelessWidget {
  const AccountAndSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        AccountAndSettingsAppBar(),
        AccountAndSettingsListView()
      ],
    );
  }
}