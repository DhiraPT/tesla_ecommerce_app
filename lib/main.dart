import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/firebase_options.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/home_screen.dart';
import 'package:tesla_ecommerce_app/screens/wishlist_screen/wishlist_screen.dart';
import 'package:tesla_ecommerce_app/screens/shopping_cart_screen/shopping_cart_screen.dart';
import 'package:tesla_ecommerce_app/screens/account_and_settings_screen/account_and_settings_screen.dart';
import 'package:tesla_ecommerce_app/components/bottom_navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(const ProviderScope(child: MyApp()));
}

final pageIndexProvider = StateProvider<int>(
  (ref) => 0,
);

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  List pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const ShoppingCartScreen(),
    const AccountAndSettingsScreen()
  ];

  void onNavButtonTapped(int index) {
    ref.watch(pageIndexProvider.notifier).update((state) => index);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(pageIndexProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tesla Ecommerce App',
      theme: ThemeData(
        primaryColor: Colors.white,
        cardColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:
            const AppBarTheme(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.black),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Color(0xFF555555)),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontFamily: "Montserrat"
        ),
        fontFamily: "Montserrat"
      ),
      home: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: pages[pageIndex],
            bottomNavigationBar: BottomNavBar(pageIndex: pageIndex, onNavButtonTapped: onNavButtonTapped),
          )
        )
      )
    );
  }
}
