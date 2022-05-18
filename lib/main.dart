import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:tesla_ecommerce_app/screens/home_screen/home_screen.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
        primaryColor: Colors.lightBlue,
        cardColor: Colors.white,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1.0),
        scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1.0),
        appBarTheme:
            const AppBarTheme(color: Color.fromRGBO(250, 250, 250, 1.0)),
        iconTheme: const IconThemeData(color: Colors.black),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Color(0xFF555555)),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.black, fontSize: 24.0),
          headline2: TextStyle(fontSize: 20.0),
          bodyText2: TextStyle(fontSize: 14.0),
        ),
        fontFamily: "Montserrat"
      ),
      home: const HomeScreen(),
    );
  }
}
