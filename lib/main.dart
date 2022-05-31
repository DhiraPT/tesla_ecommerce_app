import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
        fontFamily: "Montserrat"
      ),
      home: const HomeScreen(),
    );
  }
}
