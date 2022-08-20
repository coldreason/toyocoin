import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackkorea2022/app/data/repositories/map_repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MapController extends GetxController {
  //TODO: Implement MapController

  final MapRepository repository;

  Completer<GoogleMapController> googleMapController = Completer();
  RxList<Marker> avalableNode = <Marker>[].obs;
  List<LatLng> selectedNode = <LatLng>[];

  RxList<Polyline> toAllNode = <Polyline>[].obs;
  List<Polyline> toSelectedNode = <Polyline>[];

  List<List<DateTime>> dateList = [];
  late DateTime startDate;
  late int diff;

  Rx<CameraPosition> cameraCenter = CameraPosition(
    target: LatLng(40.679, -73.942),
    zoom: 12.4746,
  ).obs;

  MapController({required this.repository}) : assert(repository != null);

  @override
  void onInit() async {
    super.onInit();
    List<LatLng>? allLatLng = await repository.getAvailableNode();
    List<Marker> markerList = [];
    allLatLng!.forEach((element) => markerList.add(Marker(
        markerId: MarkerId(
            (element.latitude.toString() + element.longitude.toString())),
        draggable: false,
        icon: BitmapDescriptor.defaultMarker,
        //todo: change to selectable marker
        onTap: () {
          selectMarker(
              element.latitude.toString() + element.longitude.toString());
        },
        //todo : add marker to page
        position: LatLng(element.latitude, element.longitude))));
    avalableNode.value = markerList;
    await selectMarker(avalableNode.value[0].markerId.value);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}



  String _getMarkerId(LatLng posi) =>
      (posi.latitude.toString() + posi.longitude.toString());

  String _getPolyId(LatLng posi1, LatLng posi2) =>
      (_getMarkerId(posi1) + _getMarkerId(posi2));

  selectMarker(String targetMarkerId) async {


    Marker targetNode = avalableNode.value
        .singleWhere((element) => element.markerId.value == targetMarkerId);
    avalableNode.value.remove(targetNode);
    avalableNode.value.add(Marker(
        markerId: MarkerId((targetMarkerId)),
        draggable: false,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        //todo: change to selectable marker
        onTap: () {},
        position: targetNode.position));
    selectedNode.add(targetNode.position);

    List<LatLng>? toSelectedLine =
        await repository.getRecommendNode(selectedNode);

    List<Polyline> polylineList = [];
    toSelectedLine!.forEach((element) => polylineList.add(Polyline(
        polylineId: PolylineId(_getPolyId(targetNode.position, element)),
        visible: true,
        points: [targetNode.position, element],
        width: 6,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap)));
    if (selectedNode.length > 1) {//avoid initial trying
      toSelectedNode.add(Polyline(
          polylineId: PolylineId(_getPolyId(
              selectedNode[selectedNode.length - 2],
              selectedNode[selectedNode.length - 1])),
          visible: true,
          points: [
            selectedNode[selectedNode.length - 2],
            selectedNode[selectedNode.length - 1]
          ],
          width: 4,
          color: Colors.blue,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));
    }
    toAllNode.value = [];
    toAllNode.value.addAll(polylineList);
    toAllNode.value.addAll(toSelectedNode);
    //get recommended node

    update();
    await Get.dialog(
      AlertDialog(
        content: Container(
          height: 300,
          width: 200,
          child: SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                      ),
        ),
        actions: [
          TextButton(
            child: const Text("Save"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
    List<DateTime> date = [];
    for(int i = 0;i<diff+1;i++){
      date.add(startDate.add(Duration(days: i)));
    }
    dateList.add(date);
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      var start = args.value.startDate as DateTime;
      var end = (args.value.endDate ?? args.value.startDate) as DateTime;
      startDate = start;
      diff = end.difference(start).inDays;
    }
  }
}
