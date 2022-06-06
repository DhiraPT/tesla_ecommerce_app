import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';
import 'package:tesla_ecommerce_app/screens/login_screen/login_screen.dart';
import 'package:tesla_ecommerce_app/services/firebase_auth_service.dart';

class AccountAndSettingsListView extends ConsumerStatefulWidget {
  const AccountAndSettingsListView({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountAndSettingsListView> createState() => _AccountAndSettingsListViewState();
}

class _AccountAndSettingsListViewState extends ConsumerState<AccountAndSettingsListView> {
  late FirebaseAuthService firebaseAuthService;

  @override
  void initState() {
    super.initState();
    firebaseAuthService = FirebaseAuthService();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    if (authState.asData?.value != null) {
      return SliverList(
        delegate: SliverChildListDelegate([
          const ListTile(title: Text('My Account'), enabled: false),
          const ListTile(title: Text('My Profile')),
          const ListTile(title: Text('My Addresses')),
          const ListTile(title: Text('Linked Payment Methods')),
          const ListTile(title: Text('Settings'), enabled: false),
        ])
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate([
          const ListTile(title: Text('My Account'), enabled: false),
          ListTile(
            leading: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }, 
              child: const Text('Log In')
            ), 
            title: TextButton(
              onPressed: () {}, 
              child: const Text('Sign Up')
            )
          ),
          const ListTile(title: Text('Settings'), enabled: false),
        ])
      );
    }
  }
}
