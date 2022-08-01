import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/ApiService.dart';
import '../../apiservice/EndPoints.dart';
import '../ui/DashBoardScreen.dart';
import '../../utils/LocalStorageName.dart';
import '../../utils/Utils.dart';

class TotalOrdersProvider {
  Future<String> totalorder(userid) async {
    var ApiCalling = GetApiInstance();
    Response response;
    response = await ApiCalling.get(totalorders + "/" + userid);
    print("responseresponse " + response.data.toString());
    if (response.statusCode == 200) {
      return response.data.toString();
    }
    return "0";
  }
}
