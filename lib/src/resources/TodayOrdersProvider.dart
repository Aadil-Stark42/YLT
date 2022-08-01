import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/ApiService.dart';
import '../../apiservice/EndPoints.dart';
import '../ui/DashBoardScreen.dart';
import '../../utils/LocalStorageName.dart';
import '../../utils/Utils.dart';

class TodayOrdersProvider {
  Future<String> todayorder(userid) async {
    var ApiCalling = GetApiInstance();
    Response response;
    response = await ApiCalling.get(todayorders + "/" + userid);
    if (response.statusCode == 200) {
      return response.data.toString();
    }
    return "0";
  }
}
