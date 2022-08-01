import 'dart:async';
import 'package:deliveryapp/src/models/OrdersDataModel.dart';
import 'package:deliveryapp/src/resources/ApproveOrdersProvider.dart';
import 'package:deliveryapp/src/resources/ChangeStatusOrdersProvider.dart';
import 'package:deliveryapp/src/resources/CompleteOrdersProvider.dart';
import 'package:deliveryapp/src/resources/LoginProvider.dart';
import 'package:deliveryapp/src/resources/OrdersProvider.dart';
import 'package:deliveryapp/src/resources/PendingOrdersProvider.dart';
import 'package:deliveryapp/src/resources/ProcessOrdersProvider.dart';
import 'package:deliveryapp/src/resources/TodayOrdersProvider.dart';
import 'package:deliveryapp/src/resources/TotalOrdersProvider.dart';

class Repository {
  final loginProvider = LoginProvider();

  Future<void> loginapi(emailid, pass, context) =>
      loginProvider.login(emailid, pass, context);

/*--------*/
  final totalProvider = TotalOrdersProvider();

  Future<String> totalOrders(userid) => totalProvider.totalorder(userid);

  /*--------*/
  final todayProvider = TodayOrdersProvider();

  Future<String> todayOrder(userid) => todayProvider.todayorder(userid);

  /*--------*/
  final pendinProvider = PendingOrdersProvider();

  Future<List<OrdersDataModel>> pendingOrder(userid) =>
      pendinProvider.pendingorder(userid);

  /*--------*/
  final processProvider = ProcessOrdersProvider();

  Future<List<OrdersDataModel>> processOrder(userid) =>
      processProvider.processorder(userid);

  /*--------*/
  final completeProvider = CompleteOrdersProvider();

  Future<List<OrdersDataModel>> completeOrder(userid) =>
      completeProvider.completeorder(userid);

  /*--------*/
  final ordersProvider = OrdersProvider();

  Future<List<OrdersDataModel>> Orders(userid) => ordersProvider.order(userid);

  /*--------*/
  final approveordersProvider = ApproveOrdersProvider();

  Future<int> approveOrder(orderid, statuss) =>
      approveordersProvider.approveorder(orderid, statuss);

  /*--------*/
  final changeProvider = ChangeStatusOrdersProvider();

  Future<int> changeOrder(orderid, statuss) =>
      changeProvider.changeorder(orderid, statuss);
}
