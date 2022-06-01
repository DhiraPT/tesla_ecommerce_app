import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/profile_and_settings_screen/components/profile_and_settings_appbar.dart';

class ProfileAndSettingsScreen extends StatelessWidget {
  const ProfileAndSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        ProfileAndSettingsAppBar(),
      ],
    );
  }
}