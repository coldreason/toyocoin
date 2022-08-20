import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 500,
            child: GetBuilder<MapController>(
              builder: (_){
              return GoogleMap(
                mapType: MapType.terrain,
                markers: Set.from(_.avalableNode.value),
                polylines: Set.from(_.toAllNode.value),
                initialCameraPosition: _.cameraCenter.value,
                onMapCreated: (GoogleMapController _controller) {
                  _.googleMapController.complete(_controller);
                },
              );}
            ),
          ),
        ],
      ),
    );
  }
}
