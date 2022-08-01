import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/ApiService.dart';
import '../../apiservice/EndPoints.dart';
import '../ui/DashBoardScreen.dart';
import '../../utils/LocalStorageName.dart';
import '../../utils/Utils.dart';

class LoginProvider {
  Future<void> login(emailid, pass, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Params = <String, dynamic>{};
    Params[email] = emailid;
    Params[password] = pass;
    print("loginParams ${Params.toString()}");
    var ApiCalling = GetApiInstance();
    Response response;
    response = await ApiCalling.post(loginApi, data: Params);
    print("loginApiCalling${response.data.toString()}");
    if (response.statusCode == 200) {
      ShowToast("Login successfully", context);
      prefs.setBool(isLogin, true);
      prefs.setString(loginUser, json.encode(response.data).toString());
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashBoardScreen(),
        ),
      );
    }
  }
}
