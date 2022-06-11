import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/services/firebase_auth_service.dart';
import 'package:tuple/tuple.dart';

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});

final signUpProvider = FutureProvider.autoDispose.family<String, Tuple2<String, String>>(
  (ref, emailAddressPassword) async {
    return ref.read(authServiceProvider).signUp(emailAddressPassword);
  }
);

final logInProvider = FutureProvider.autoDispose.family<String, Tuple2<String, String>>(
  (ref, emailAddressPassword) async {
    return ref.read(authServiceProvider).logIn(emailAddressPassword);
  }
);

final logInWithGoogleProvider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(authServiceProvider).logInWithGoogle();
});

final logOutProvider = FutureProvider.autoDispose<String>((ref) async {
  return ref.read(authServiceProvider).logOut();
});
