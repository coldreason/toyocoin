import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BackEndProvider {
  String serverAddress = 'http://3.235.63.27:5000';
  Future<bool> postCheckNewUserRequest(String uid) async {
    Uri url = Uri.parse(serverAddress+'/get');
    late http.Response response;

    try{
      response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({'key':uid}));
    } catch(_){
      Get.snackbar(
          "Error Occured",_.toString()
      );
    }
    print(json.decode(response.body));
    return json.decode(response.body);
  }
}