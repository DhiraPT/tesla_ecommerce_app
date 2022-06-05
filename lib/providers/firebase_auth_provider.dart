import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tesla_ecommerce_app/services/firebase_auth_service.dart';

final authServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});
