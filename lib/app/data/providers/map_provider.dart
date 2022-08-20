import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider {
  Future<List<LatLng>?> getAvailableNode() async {
    try {
      List<LatLng> availableNode = [
        LatLng(40.648, -73.921),
        LatLng(40.629, -73.932),
        LatLng(40.690, -73.943),
        LatLng(40.631, -73.954),
        LatLng(40.702, -73.965)
      ];
      return availableNode;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<LatLng>?> getRecommendNode(List<LatLng> selected) async {
    try {
      List<LatLng> availableNode = [
        LatLng(40.629, -73.932),
        LatLng(40.690, -73.943),
        LatLng(40.631, -73.954),
      ];
      return availableNode;
    } catch (error) {
      print(error);
      return null;
    }
  }
}
