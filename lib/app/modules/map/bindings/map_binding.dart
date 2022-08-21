import 'package:get/get.dart';
import 'package:hackkorea2022/app/data/providers/back_end_provider.dart';
import 'package:hackkorea2022/app/data/providers/map_provider.dart';
import 'package:hackkorea2022/app/data/repositories/map_repository.dart';

import '../controllers/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(repository: MapRepository(mapProvider: MapProvider(), backEndProvider: BackEndProvider(),)),
    );
  }
}
