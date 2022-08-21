import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackkorea2022/app/data/repositories/map_repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

Future<Uint8List> getBytesFromAsset(
    {required String path, required int width}) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

class MapController extends GetxController {
  final MapRepository repository;

  Completer<GoogleMapController> googleMapController = Completer();
  RxList<Marker> avalableNode = <Marker>[].obs;
  List<LatLng> selectedNode = <LatLng>[];

  RxList<Polyline> toAllNode = <Polyline>[].obs;
  List<Polyline> toSelectedNode = <Polyline>[];

  List<List<DateTime>> dateList = [];
  late DateTime startDate;
  late int diff;
  final List<Uint8List> customMarkers = [];
  late int index;
  Rx<CameraPosition> cameraCenter = CameraPosition(
    target: LatLng(41.901029, 12.493752),
    zoom: 8.4746,
  ).obs;

  MapController({required this.repository}) : assert(repository != null);

  @override
  void onInit() async {
    super.onInit();
    index = 1;
    customMarkers.add(await getBytesFromAsset(
        path: 'assets/image/etc.png', //paste the custom image path
        width: 80 // size of custom image as marker
        ));
    customMarkers.add(await getBytesFromAsset(
        path: 'assets/image/start.png', //paste the custom image path
        width: 80 // size of custom image as marker
        ));
    customMarkers.add(await getBytesFromAsset(
        path: 'assets/image/n2.png', //paste the custom image path
        width: 80 // size of custom image as marker
        ));
    customMarkers.add(await getBytesFromAsset(
        path: 'assets/image/n3.png', //paste the custom image path
        width: 80 // size of custom image as marker
        ));
    customMarkers.add(await getBytesFromAsset(
        path: 'assets/image/n4.png', //paste the custom image path
        width: 80 // size of custom image as marker
        ));

    List<LatLng>? allLatLng = await repository.getAvailableNode();
    // List<String> allNode = (await repository.getAllNodeList()) as List<String>;
    List<Marker> markerList = [];
    allLatLng!.forEach((element) => markerList.add(Marker(
        markerId: MarkerId((_getMarkerId(element))),
        draggable: false,
        icon: BitmapDescriptor.fromBytes(customMarkers[0]),
        //todo: change to selectable marker
        onTap: () {
          selectMarker(_getMarkerId(element));
        },
        //todo : add marker to page
        position: LatLng(element.latitude, element.longitude))));
    avalableNode.value = markerList;
    String initialNode = Get.arguments['result'];
    // if (Get.arguments['finished'] ?? false) {}

    LatLng initial =
        await repository.mapProvider.dataProvider.geodata[initialNode]!;
    await selectMarker(_getMarkerId(initial));
    update();
  }

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
        icon: BitmapDescriptor.fromBytes(customMarkers[index]),
        //todo: change to selectable marker
        onTap: () {},
        position: targetNode.position));
    index = index + 1;
    if (index > 4) index = 4;
    selectedNode.add(targetNode.position);

    List<LatLng>? toSelectedLine =
        await repository.getRecommendNode(selectedNode);

    List<Polyline> polylineList = [];
    toSelectedLine!.forEach((element) => polylineList.add(Polyline(
        polylineId: PolylineId(_getPolyId(targetNode.position, element)),
        visible: true,
        points: [targetNode.position, element],
        width: 6,
        color: Colors.purple,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap)));
    if (selectedNode.length > 1) {
      //avoid initial trying
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
            startRangeSelectionColor: Color(0xff665EFF),
            endRangeSelectionColor: Color(0xff665EFF),
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
    date.add(startDate.add(Duration(days: 0)));
    date.add(startDate.add(Duration(days: diff)));
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

  void saveNode() async {
    avalableNode.value = [];
    toAllNode.value = [];
    for (var i = 0; i < selectedNode.length; i++) {
      avalableNode.add(Marker(
          onTap: () {
            List<Map> lie = [];
            for (int j = 0;
                j < repository.mapProvider.dataProvider.userdata.length;
                j++) {
              if (repository.mapProvider.dataProvider.userdata[j]
                      [i.toString()] ==
                  dateList[i]) {
                print(dateList[i]);
                print(repository.mapProvider.dataProvider.userdata[j]
                    [i.toString()]);
                lie.add(repository.mapProvider.dataProvider.user[j]);
              }
            }

            Get.bottomSheet(Container(
              height: 600,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      '당신을 기다리고 있어요!',
                      style: TextStyle(color: Color(0xff609DFF), fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 30,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (BuildContext context, int index) {
                        String k = 'assets/image/' +
                            (index % 6 + 1).toString() +
                            '.jpg';
                        return MaterialButton(
                          onPressed: () {
                            Get.bottomSheet(Container(
                              height: 600,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                      width: 160,
                                      child: Image(image: AssetImage(k))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '김이름',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 40),
                                    child: Text(
                                        '안녕하세요! 체코 맛집을 다 뿌시고 오고 싶은 21살 김이름이라고 합니다! ㅎㅎ 😊',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                      height: 60,
                                      child: sendButton())
                                ],
                              ),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(children: [
                              Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image(image: AssetImage(k))),
                              Container(
                                  width: 220,
                                  height: 50,
                                  margin: EdgeInsets.all(6),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '김이름',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '더미데이터입니다.',
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ))
                            ]),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ));
          },
          position: selectedNode[i],
          markerId: MarkerId(_getMarkerId(selectedNode[i])),
          icon: BitmapDescriptor.fromBytes(customMarkers[i < 4 ? i + 1 : 4])));
      if (i >= 1) {
        toAllNode.value.add(Polyline(
            visible: true,
            points: [avalableNode[i - 1].position, avalableNode[i].position],
            width: 6,
            color: Colors.purple,
            startCap: Cap.roundCap,
            endCap: Cap.buttCap,
            polylineId: PolylineId(_getPolyId(
                avalableNode[i - 1].position, avalableNode[i].position))));
      }
    }
    update();
  }
}


class sendButton extends StatefulWidget {
  const sendButton({Key? key}) : super(key: key);

  @override
  State<sendButton> createState() => _sendButtonState();
}

class _sendButtonState extends State<sendButton> {
  bool send = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
        width: 320,
        decoration: BoxDecoration(color: Colors.deepPurpleAccent,borderRadius: BorderRadius.circular(8)),

        child: MaterialButton(onPressed: (){setState(() {
          send = true;
        });}, child: Text(send==false?'요청':'승낙대기중',style: TextStyle(fontSize: 24,color: Colors.white),)));
  }
}
