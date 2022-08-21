import 'package:hackkorea2022/app/data/providers/back_end_provider.dart';

class IntroduceRepository {
  final BackEndProvider backEndProvider;

  IntroduceRepository({required this.backEndProvider})
      : assert(backEndProvider !=null);

  Future<void> postProfile(uid,name,phone,intro)=> backEndProvider.postUserProfileRequest(uid, name, phone,intro);

}