import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackkorea2022/app/data/models/user_model.dart';
import 'package:hackkorea2022/app/data/providers/back_end_provider.dart';
import 'package:hackkorea2022/app/data/providers/firebase_auth_provider.dart';

class LoginRepository {
  final FirebaseAuthProvider firebaseAuthProvider;
  final BackEndProvider backEndProvider;

  LoginRepository({required this.firebaseAuthProvider,required this.backEndProvider})
      : assert(firebaseAuthProvider != null,backEndProvider !=null);


  Future<UserCredential?> signIn() async => await firebaseAuthProvider.signIn();
  void signOut() => firebaseAuthProvider.signOut();
  User? getUser() => firebaseAuthProvider.getUser();

   Future<UserProgressModel> check(uid)=> backEndProvider.postCheckUserProgressRequest(uid);

}