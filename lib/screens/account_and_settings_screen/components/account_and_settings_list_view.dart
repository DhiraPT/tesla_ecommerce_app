import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';

class AccountAndSettingsListView extends ConsumerStatefulWidget {
  const AccountAndSettingsListView({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountAndSettingsListView> createState() => _AccountAndSettingsListViewState();
}

class _AccountAndSettingsListViewState extends ConsumerState<AccountAndSettingsListView> {
  @override
  Widget build(BuildContext context) {
    if (ref.read(authStateProvider).asData?.value != null) {
      return SliverList(
        delegate: SliverChildListDelegate([
          const ListTile(title: Text('My Account'), enabled: false),
          const ListTile(title: Text('My Profile')),
          const ListTile(title: Text('My Addresses')),
          const ListTile(title: Text('Linked Payment Methods')),
          const ListTile(title: Text('Settings'), enabled: false),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              ref.watch(logOutProvider.future).then((msg) {
                if (msg == 'Logout successful') {
                  EasyLoading.showSuccess(msg);
                } else {
                  EasyLoading.showError(msg);
                }
              });
            }
          ),
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
                    Navigator.pushNamed(context, '/login');
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
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
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
