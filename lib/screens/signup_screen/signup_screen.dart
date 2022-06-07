import 'package:flutter/material.dart';

import 'package:tesla_ecommerce_app/screens/signup_screen/components/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
            title: Text('Sign Up', style: Theme.of(context).textTheme.titleLarge),
          ),
          body: const Center(
            child: SingleChildScrollView(
              child: SignUpForm()
            )
          )
        )
      )
    );
  }
}