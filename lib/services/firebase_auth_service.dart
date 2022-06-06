import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future signUp(String emailAddress, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> logIn(String emailAddress, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return 'Login successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else if (e.code == 'wrong-password') {
        return 'Password incorrect';
      } else if (e.code == 'invalid-email') {
        return 'Invalid e-mail address';
      } else if (e.code == 'user-disabled') {
        return 'User disabled';
      } else {
        return 'Error logging in';
      }
    }
  }

  Future<String> logInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    
    try {
      await _auth.signInWithCredential(credential);
      return 'Login successful';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'User not found';
      } else if (e.code == 'wrong-password') {
        return 'Password incorrect';
      } else if (e.code == 'invalid-credential') {
        return 'Invalid credential';
      } else if (e.code == 'user-disabled') {
        return 'User disabled';
      } else {
        return 'Error logging in';
      }
    }

  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
