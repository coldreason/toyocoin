import 'package:get/get.dart';
import 'package:hackkorea2022/app/data/providers/back_end_provider.dart';
import 'package:hackkorea2022/app/data/providers/firebase_auth_provider.dart';
import 'package:hackkorea2022/app/data/repositories/login_repositiory.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(repository: LoginRepository(firebaseAuthProvider: FirebaseAuthProvider(), backEndProvider: BackEndProvider())),
    );
  }
}
