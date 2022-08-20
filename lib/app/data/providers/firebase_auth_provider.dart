import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  Future<UserCredential?> signIn() async {
    try {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
      // Once signed in, return the User
      return await FirebaseAuth.instance.signInWithAuthProvider(googleProvider);
    } catch (error) {
      print(error);
      return null;

    }
  }
  void signOut() async=> await FirebaseAuth.instance.signOut();

  User? getUser() => FirebaseAuth.instance.currentUser;
}
