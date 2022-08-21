import 'package:get/get.dart';

import 'package:hackkorea2022/app/modules/departure/bindings/departure_binding.dart';
import 'package:hackkorea2022/app/modules/departure/views/departure_view.dart';
import 'package:hackkorea2022/app/modules/home/bindings/home_binding.dart';
import 'package:hackkorea2022/app/modules/home/views/home_view.dart';
import 'package:hackkorea2022/app/modules/introduce/bindings/introduce_binding.dart';
import 'package:hackkorea2022/app/modules/introduce/views/introduce_view.dart';
import 'package:hackkorea2022/app/modules/login/bindings/login_binding.dart';
import 'package:hackkorea2022/app/modules/login/views/login_view.dart';
import 'package:hackkorea2022/app/modules/map/bindings/map_binding.dart';
import 'package:hackkorea2022/app/modules/map/views/map_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAP;

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
    GetPage(
      name: _Paths.DEPARTURE,
      page: () => DepartureView(),
      binding: DepartureBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCE,
      page: () => IntroduceView(),
      binding: IntroduceBinding(),
    ),
  ];
}
