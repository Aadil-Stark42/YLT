import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiservice/ApiService.dart';
import '../../apiservice/EndPoints.dart';
import '../models/OrdersDataModel.dart';
import '../ui/DashBoardScreen.dart';
import '../../utils/LocalStorageName.dart';
import '../../utils/Utils.dart';

class CompleteOrdersProvider {
  Future<List<OrdersDataModel>> completeorder(userid) async {
    List<OrdersDataModel> completeOrderList = [];
    var ApiCalling = GetApiInstance();
    Response response;
    response = await ApiCalling.get(complete + "/" + userid);
    if (response.statusCode == 200) {
      completeOrderList = response.data.map<OrdersDataModel>((json) {
        return OrdersDataModel.fromJson(json);
      }).toList();
    }
    return completeOrderList;
  }
}
