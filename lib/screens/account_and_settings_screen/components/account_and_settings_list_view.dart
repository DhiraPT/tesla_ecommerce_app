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
          ListTile(title: const Text('Log Out'), onTap: () => firebaseAuthService.logOut()),
        ])
      );
    } else {
      return SliverList(
        delegate: SliverChildListDelegate([
          const ListTile(title: Text('My Account'), enabled: false),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(width: 2.0, color: Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text('Log In', style: Theme.of(context).textTheme.titleSmall)
                )
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(width: 2.0, color: Colors.black),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                ),
                child: Text('Sign Up', style: Theme.of(context).textTheme.titleSmall)
              ),
            ]
          ),
          const ListTile(title: Text('Settings'), enabled: false),
        ])
      );
    }
  }
}
