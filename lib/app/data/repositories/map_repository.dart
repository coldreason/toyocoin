import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:hackkorea2022/app/data/providers/back_end_provider.dart';
import 'package:hackkorea2022/app/data/providers/map_provider.dart';


class MapRepository {
  final MapProvider mapProvider;
  final BackEndProvider backEndProvider;

  MapRepository({required this.mapProvider, required this.backEndProvider})
      : assert(mapProvider != null,);

  Future<List<LatLng>?> getAvailableNode() => mapProvider.getAvailableNode();

  Future<List<LatLng>?> getRecommendNode(selected) => mapProvider.getRecommendNode(selected);

  Future<LatLng> getLatLngFromaddress(address) => mapProvider.getLatLngFromaddress(address);

  getAllNodeList() => backEndProvider.getAllNodeNameList();
}