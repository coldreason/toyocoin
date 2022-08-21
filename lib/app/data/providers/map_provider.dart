import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackkorea2022/app/data/providers/data_provider.dart';

class MapProvider {
  DataProvider dataProvider = DataProvider();
  Future<LatLng> getLatLngFromaddress(String address) async{

    GeoData data = await Geocoder2.getDataFromAddress(
        address: address,
        googleMapApiKey: "AIzaSyD8sDXMWhj0n5pwvTzTHGcrSN6Rq_SECKE");
    print(data.toString());
    return LatLng(data.latitude, data.longitude);
  }
  Future<List<LatLng>?> getAvailableNode() async {
    try {

      List availableNode = dataProvider.geodata.values.toList();
      return availableNode as List<LatLng>;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<LatLng>?> getRecommendNode(List<LatLng> selected) async {
    try {
      List<LatLng> availableNode = dataProvider.geodata.values.toList();
      for(int i = 0;i<selected.length;i++){
        availableNode.remove(selected[i]);
      }
      return [availableNode[availableNode.length-1],availableNode[(availableNode.length/2).toInt()],
    availableNode[(availableNode.length/3).toInt()]];
    } catch (error) {
      print(error);
      return null;
    }
  }
}
