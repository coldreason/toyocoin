import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackkorea2022/app/data/providers/firebase_auth_provider.dart';


class LoginRepository {
  final FirebaseAuthProvider firebaseAuthProvider;

  LoginRepository({required this.firebaseAuthProvider})
      : assert(firebaseAuthProvider != null,);


  Future<UserCredential?> signIn() async => await firebaseAuthProvider.signIn();
  void signOut() => firebaseAuthProvider.signOut();
  User? getUser() => firebaseAuthProvider.getUser();

}