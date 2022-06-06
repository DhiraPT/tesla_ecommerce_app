import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/login_screen/components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: const Text('Log In'),
          ),
          body: const Center(
            child: SingleChildScrollView(
              child: LoginForm()
            )
          )
        )
      )
    );
  }
}