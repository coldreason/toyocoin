import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';

class MapView extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MapController>(
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
      floatingActionButton:  Padding(
    padding: const EdgeInsets.only(bottom: 10,right: 40),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
    Container(
      margin: EdgeInsets.all(5),
      child: FloatingActionButton(
        heroTag: "btn2",
        backgroundColor: Color(0xff665EFF),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        onPressed: (){Get.offAndToNamed('departure',arguments: {'initial':false});},
        child: Icon(Icons.refresh),
      )
    ),
    FloatingActionButton(
      heroTag: "btn1",
      backgroundColor: Color(0xff665EFF),
     shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0))),
    onPressed: () {controller.saveNode();},
    child: Icon(Icons.arrow_forward_sharp),
    )
    ],
    ),
    ));
  }
}
