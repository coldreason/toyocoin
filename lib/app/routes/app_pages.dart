import 'package:get/get.dart';

import 'package:hackkorea2022/app/modules/home/bindings/home_binding.dart';
import 'package:hackkorea2022/app/modules/home/views/home_view.dart';
import 'package:hackkorea2022/app/modules/login/bindings/login_binding.dart';
import 'package:hackkorea2022/app/modules/login/views/login_view.dart';
import 'package:hackkorea2022/app/modules/map/bindings/map_binding.dart';
import 'package:hackkorea2022/app/modules/map/views/map_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
  ];
}
