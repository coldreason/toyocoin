import 'dart:convert';

import 'package:get/get.dart';
import 'package:hackkorea2022/app/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class BackEndProvider {
  String serverAddress = 'http://43.200.5.165:8888';
  Future<UserProgressModel> postCheckUserProgressRequest(String uid) async {
    Uri url = Uri.parse(serverAddress+'/user/duplicatecheck');
    late http.Response response;

    try{
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'loginId':uid}));
    } catch(_){
      Get.snackbar(
          "Error Occured",_.toString()
      );
    }
    return UserProgressModel.fromJson(json.decode(response.body));
  }

  Future<void> postUserProfileRequest(String uid,String name,String phone,String intro) async {
    Uri url = Uri.parse(serverAddress+'/user/signup');
    late http.Response response;

    try{
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'loginId':uid,'nickName':name,'introduce':intro,'contact':phone}));
    } catch(_){
      Get.snackbar(
          "Error Occured",_.toString()
      );
    }
  }

   dynamic getAllNodeNameList() async {
    Uri url = Uri.parse(serverAddress+'/trip/show');
    late http.Response response;

    try{
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({}));
    } catch(_){
      Get.snackbar(
          "Error Occured",_.toString()
      );
    }
    print(json.decode(response.body));
    return json.decode(response.body);
  }

  dynamic getPersonalInfo(String uid) async {
    Uri url = Uri.parse(serverAddress+'/user/Profile');
    late http.Response response;

    try{
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'loginId':uid}));
    } catch(_){
      Get.snackbar(
          "Error Occured",_.toString()
      );
    }
    print(json.decode(response.body));
    return json.decode(response.body);
  }

}