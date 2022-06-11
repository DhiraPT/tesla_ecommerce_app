import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/firebase_options.dart';
import 'package:tesla_ecommerce_app/screens/camera_screen/camera_screen.dart';
import 'package:tesla_ecommerce_app/screens/login_screen/login_screen.dart';
import 'package:tesla_ecommerce_app/screens/product_screen/product_screen.dart';
import 'package:tesla_ecommerce_app/screens/signup_screen/signup_screen.dart';
import 'package:tesla_ecommerce_app/components/bottom_tab_navigator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This widget is the root of your application.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tesla Ecommerce App',
      theme: ThemeData(
          primaryColor: Colors.white,
          cardColor: Colors.white,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            elevation: 0,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: Color(0xFF555555)),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
              fontFamily: "Montserrat"),
          fontFamily: "Montserrat"),
      builder: EasyLoading.init(),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomTabNavigator(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/camera': (context) => const CameraScreen(),
        '/product': (context) => const ProductScreen(),
      },
    );
  }
}
