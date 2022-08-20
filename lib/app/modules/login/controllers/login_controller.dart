import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hackkorea2022/app/data/repositories/login_repositiory.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final LoginRepository repository;

  LoginController({required this.repository}) : assert(repository != null);

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void signIn() async {
    UserCredential? ret = await repository.signIn();
    if(ret == null){
      // error on sign in
      return null;
    }
    print(repository.checkNewUser(ret.user!.uid)==true?'newUser':'no');
    Get.toNamed('/home');
  }
}
