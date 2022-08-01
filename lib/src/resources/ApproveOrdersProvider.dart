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

class ApproveOrdersProvider {
  Future<int> approveorder(orderid, statuss) async {
    var Params = <String, dynamic>{};
    Params[id] = orderid;
    Params[status] = statuss;
    print("loginParams ${Params.toString()}");
    var ApiCalling = GetApiInstance();
    Response response;
    response = await ApiCalling.post(approve, data: Params);
    print("responseresponse ${response.data.toString()}");
    if (response.statusCode == 200) {
      return response.data[code];
    }
    return 404;
  }
}
