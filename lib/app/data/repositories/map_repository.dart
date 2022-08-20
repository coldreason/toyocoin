import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hackkorea2022/app/data/providers/map_provider.dart';


class MapRepository {
  final MapProvider mapProvider;

  MapRepository({required this.mapProvider})
      : assert(mapProvider != null,);

  Future<List<LatLng>?> getAvailableNode() => mapProvider.getAvailableNode();

  Future<List<LatLng>?> getRecommendNode(selected) => mapProvider.getRecommendNode(selected);

}