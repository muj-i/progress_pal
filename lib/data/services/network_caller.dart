import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:progress_pal/data/model/network_responce.dart';

class NetworkCaller {
  //get request
  Future<NetworkResponce> getRequest(String url) async {
    try {
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        return NetworkResponce(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponce(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return const NetworkResponce(false, -1, null);
  }

  //post request
  Future<NetworkResponce> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body));

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponce(
            true, response.statusCode, jsonDecode(response.body));
      } else {
        return NetworkResponce(false, response.statusCode, null);
      }
    } catch (e) {
      log(e.toString());
    }
    return const NetworkResponce(false, -1, null);
  }
}
