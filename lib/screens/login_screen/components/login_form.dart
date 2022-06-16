import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/providers/firebase_auth_provider.dart';
import 'package:tuple/tuple.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  late TextEditingController _emailTextEditingController, 
    _passwordTextEditingController;
  late TapGestureRecognizer _tapGestureRecognizer;
  late bool _passwordVisible;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      onChanged: () => setState(() {}),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextFormField(
              controller: _emailTextEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)
                  ? null : 'Please enter a valid e-mail address.';
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                helperText: '',
                filled: true,
                fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
                prefixIcon:
                    const Icon(CupertinoIcons.person, color: Colors.black),
                hintText: 'E-mail Address',
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(162, 162, 162, 1.0)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(245, 245, 245, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(245, 245, 245, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(162, 162, 162, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: TextFormField(
              controller: _passwordTextEditingController,
              obscureText: !_passwordVisible,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                helperText: '',
                filled: true,
                fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                hintText: 'Password',
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(162, 162, 162, 1.0)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(245, 245, 245, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(245, 245, 245, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3.0, color: Color.fromRGBO(162, 162, 162, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  splashRadius: 10.0,
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: (_emailTextEditingController.text.trim().isEmpty ||
              _passwordTextEditingController.text.isEmpty)
                ? TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text('Log In', style: Theme.of(context).textTheme.titleSmall!
                    .copyWith(color: const Color.fromRGBO(162, 162, 162, 1.0)))
                )
                : OutlinedButton(
                  onPressed: () {
                    ref.watch(logInProvider(
                      Tuple2(_emailTextEditingController.text, _passwordTextEditingController.text)
                    ).future).then((msg) {
                      if (msg == 'Login successful') {
                        EasyLoading.showSuccess(msg);
                        Navigator.of(context).pop();
                      } else {
                        EasyLoading.showInfo(msg);
                      }
                    })
                    .onError((error, stackTrace) {
                      Center(child: Text(error.toString()));
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(width: 2.0, color: Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text('Log In', style: Theme.of(context).textTheme.titleSmall)
                )
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: Text('OR', textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Don\'t have an account yet? ',
                    style: TextStyle(color: Colors.black)
                  ),
                  TextSpan(
                    text: 'Create one.',
                    style: const TextStyle(color: Color.fromRGBO(0, 0, 238, 1.0)),
                    recognizer: _tapGestureRecognizer
                      ..onTap = () {
                        Navigator.pushNamed(context, '/signup');
                      },
                  )
                ]
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: OutlinedButton.icon(
              onPressed: () {
                ref.watch(logInWithGoogleProvider.future).then((msg) {
                  if (msg == 'Login successful') {
                    EasyLoading.showSuccess(msg);
                    Navigator.of(context).pop();
                  } else {
                    EasyLoading.showInfo(msg);
                  }
                })
                .onError((error, stackTrace) {
                  Center(child: Text(error.toString()));
                });
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(width: 2.0, color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              icon: Image.asset(
                'assets/google_logo.png',
                height: 24.0,
              ),
              label: const Text('Continue with Google'),
            ),
          ),
        ]
      ),
    );
  }
}
