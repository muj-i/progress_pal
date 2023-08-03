import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_pal/app.dart';
import 'package:progress_pal/data/model/network_response.dart';
import 'package:progress_pal/data/utils/auth_utils.dart';
import 'package:progress_pal/ui/pages/auth/login_page.dart';

class NetworkCaller {
  //get request
  Future<NetworkResponse> getRequest(String url) async {
    try {
      Response response = await get(
        Uri.parse(url),
        headers: {"token": AuthUtils.userInfo.token.toString()},
      );
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        backToLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error occurred during GET request: $e');
    }
    return const NetworkResponse(false, -1, null);
  }

  //post request
  Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "token": AuthUtils.userInfo.token.toString()
          },
          body: jsonEncode(body));

      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
            true, response.statusCode, jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        backToLogin();
      } else {
        return NetworkResponse(false, response.statusCode, null);
      }
    } catch (e) {
      log('Error occurred during POST request: $e');
    }
    return const NetworkResponse(false, -1, null);
  }

  Future<void> backToLogin() async {
    await AuthUtils.clearUserInfo();
    Navigator.pushAndRemoveUntil(ProgressPalApp.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  }
}
