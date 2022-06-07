import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/services/firebase_auth_service.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends ConsumerState<SignUpForm> {
  late FirebaseAuthService firebaseAuthService;
  late TextEditingController _emailTextEditingController, 
    _passwordTextEditingController;
  late bool _passwordVisible, _password2Visible;
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firebaseAuthService = FirebaseAuthService();
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
    _passwordVisible = false;
    _password2Visible = false;
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpFormKey,
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
            child: TextFormField(
              obscureText: !_password2Visible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != _passwordTextEditingController.text) {
                  return 'Passwords do not match.';
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                helperText: '',
                filled: true,
                fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
                hintText: 'Confirm Password',
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
                    _password2Visible ? Icons.visibility : Icons.visibility_off,
                  ),
                  splashRadius: 10.0,
                  onPressed: () {
                    setState(() {
                      _password2Visible = !_password2Visible;
                    });
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: (_emailTextEditingController.text.trim().isEmpty ||
              _passwordTextEditingController.text.isEmpty || 
              !_signUpFormKey.currentState!.validate())
                ? TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(245, 245, 245, 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text('Sign Up', style: Theme.of(context).textTheme.titleSmall!
                    .copyWith(color: const Color.fromRGBO(162, 162, 162, 1.0)))
                )
                : OutlinedButton(
                  onPressed: () {
                    firebaseAuthService.signUp(_emailTextEditingController.text, _passwordTextEditingController.text)
                    .then((msg) {
                      if (msg == 'Sign up successful') {
                        EasyLoading.showSuccess(msg);
                        Navigator.popUntil(context, ModalRoute.withName('/'));
                      } else {
                        EasyLoading.showError(msg);
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(width: 2.0, color: Colors.black),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  child: Text('Sign Up', style: Theme.of(context).textTheme.titleSmall)
                )
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: Text('OR', textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
            child: OutlinedButton.icon(
              onPressed: () {
                firebaseAuthService.logInWithGoogle()
                .then((msg) {
                  if (msg == 'Login successful') {
                    EasyLoading.showSuccess(msg);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  } else {
                    EasyLoading.showError(msg);
                  }
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
