import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants.dart';
class FUserModel {
  final String name;
  final String introduce;
  final String phone;

  FUserModel({required this.name,required this.introduce,required this.phone});

  FUserModel.fromJson(Map<String, Object?> json)
      : this(
    name: json[FirestoreConstants.name]! as String,
    introduce: json[FirestoreConstants.introduce]! as String,
    phone: json[FirestoreConstants.phone]! as String,
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[FirestoreConstants.name] = name;
    data[FirestoreConstants.introduce] = introduce;
    data[FirestoreConstants.phone] = phone;
    return data;
  }
}
class NodeModel {
  final List<dynamic?> people;
  final GeoPoint posi;

  NodeModel({required this.people,required this.posi});

  NodeModel.fromJson(Map<String, Object?> json)
      : this(
    people: json[FirestoreConstants.people]! as List<dynamic>,
    posi: json[FirestoreConstants.posi]! as GeoPoint ,
  );

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[FirestoreConstants.name] = people;
    data[FirestoreConstants.introduce] = people;
    data[FirestoreConstants.phone] = people;
    return data;
  }
}




class DataProvider {
  Map<String,dynamic> user = {
    '0':['김연준','01073133972','안녕하세요^^'],
    '1':['안서형','0101243232','안녕하세요^^'],
    '2':['김','01012343972','안녕하세요^^'],
    '3':['한나','010124272','안녕하세요^^']
  };
  Map<String,LatLng> geodata = {
    '로마':LatLng(41.901029, 12.493752),
    '나폴리':LatLng(40.944093, 14.253806),
    '바리':LatLng( 41.114395, 17.081885),
    '레체':LatLng(40.452060, 18.158087),
    '테르니':LatLng(42.607509, 12.676651),
    '볼로나':LatLng(43.357890, 11.300618),
    '시에나':LatLng(43.883585, 11.307341),
    '플로렌스':LatLng(43.883585, 11.307341),
    '페라라':LatLng( 44.930700, 11.596470),
    '밀라노':LatLng(45.499093, 9.290164),
    '니스':LatLng(43.772017, 7.279709),
  };

  List<Map<String,dynamic>> userdata = [{
    '로마':[1,2,3,4,5,6,7,8,9,10],
    '나폴리':[1,2,3,6,21],
    '바리':[1,2,3,6,21],
    '레체':[1,2,3,6,21],
    '테르니':[1,2,3,6,21],
    '볼로나':[1,2,3,6,21],
    '시에나':[1,2,3,6,21],
    '플로렌스':[1,2,3,6,21],
    '페라라':[1,2,3,6,21],
    '밀라노':[1,2,3,6,21],
    '니스':[1,2,3,6,21],
  },{
    '로마':[1,4,9,26,21],
    '나폴리':[1,2,3,6,21],
    '바리':[1,2,3,6,21],
    '레체':[1,2,3,6,21],
    '테르니':[1,2,3,6,21],
    '볼로나':[1,2,3,6,21],
    '시에나':[1,2,3,6,21],
    '플로렌스':[1,2,3,6,21],
    '페라라':[1,2,3,6,21],
    '밀라노':[1,2,3,6,21],
    '니스':[1,2,3,6,21],
  },
    {
      '로마':[1,4,9,26,21],
      '나폴리':[1,2,3,6,21],
      '바리':[1,2,3,6,21],
      '레체':[1,2,3,6,21],
      '테르니':[1,2,3,6,21],
      '볼로나':[1,2,3,6,21],
      '시에나':[1,2,3,6,21],
      '플로렌스':[1,2,3,6,21],
      '페라라':[1,2,3,6,21],
      '밀라노':[1,2,3,6,21],
      '니스':[1,2,3,6,21],
    },
    {
      '로마':[1,4,9,26,21],
      '나폴리':[1,2,3,6,21],
      '바리':[1,2,3,6,21],
      '레체':[1,2,3,6,21],
      '테르니':[1,2,3,6,21],
      '볼로나':[1,2,3,6,21],
      '시에나':[1,2,3,6,21],
      '플로렌스':[1,2,3,6,21],
      '페라라':[1,2,3,6,21],
      '밀라노':[1,2,3,6,21],
      '니스':[1,2,3,6,21],
    }
  ];

}