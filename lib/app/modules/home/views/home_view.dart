import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';

import 'package:get/get.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children:[
          Container(
            height: 600,
              child: MapSample())
          ],
        ),
      ),
    );
  }
}


List<Marker> markers = [];
List<Polyline> polylines = [];

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.677939, -73.941755),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(40.677939, -73.941755),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            child: GoogleMap(
              mapType: MapType.terrain,
              markers: Set.from(markers),
              polylines: Set.from(polylines),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          TextButton(onPressed: computePath, child: Text('test'))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    markers.add(Marker(
        markerId: MarkerId("1"),
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        onTap: () => print("Marker!"),
        position: LatLng(40.677939, -73.941755)));

  }

  computePath()async{
    GoogleMapPolyline googleMapPolyline =
    new  GoogleMapPolyline(apiKey:  "AIzaSyD8sDXMWhj0n5pwvTzTHGcrSN6Rq_SECKE");

    List<LatLng>? k = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(40.677939, -73.941755),
        destination: LatLng(40.698432, -73.924038),
        mode:  RouteMode.driving);
    k = [LatLng(40.677939, -73.941755),LatLng(40.698432, -73.924038)];
    setState(() {
      polylines.add(Polyline(
          polylineId: PolylineId('iter'),
          visible: true,
          points: k!,
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap
      ));
    });
    print(polylines);
  }
}