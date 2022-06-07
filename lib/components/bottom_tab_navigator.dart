import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/components/bottom_navbar.dart';

import 'package:tesla_ecommerce_app/screens/account_and_settings_screen/account_and_settings_screen.dart';
import 'package:tesla_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:tesla_ecommerce_app/screens/shopping_cart_screen/shopping_cart_screen.dart';
import 'package:tesla_ecommerce_app/screens/wishlist_screen/wishlist_screen.dart';

final pageIndexProvider = StateProvider<int>(
  (ref) => 0,
);

class BottomTabNavigator extends ConsumerStatefulWidget {
  const BottomTabNavigator({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomTabNavigator> createState() => _BottomTabNavigatorState();
}

class _BottomTabNavigatorState extends ConsumerState<BottomTabNavigator> {
  List pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const ShoppingCartScreen(),
    const AccountAndSettingsScreen()
  ];

  void onNavButtonTapped(int index) {
    ref.watch(pageIndexProvider.notifier).update((state) => index);
  }
  
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(pageIndexProvider);
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: pages[pageIndex],
          bottomNavigationBar: BottomNavBar(pageIndex: pageIndex, onNavButtonTapped: onNavButtonTapped),
        )
      )
    );
  }
}