import 'package:deliveryapp/res/ResColor.dart';
import 'package:deliveryapp/src/bloc/OrderBloc.dart';
import 'package:deliveryapp/src/bloc/PendingOrderBloc.dart';
import 'package:deliveryapp/src/bloc/ProcessOrderBloc.dart';
import 'package:deliveryapp/src/bloc/TodayOrderBloc.dart';
import 'package:deliveryapp/src/bloc/TotalOrderBloc.dart';
import 'package:deliveryapp/src/resources/repository.dart';
import 'package:deliveryapp/src/ui/DetailsScreen.dart';
import 'package:deliveryapp/utils/Constants.dart';
import 'package:deliveryapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../apiservice/EndPoints.dart';
import '../../res/ResString.dart';
import '../bloc/CompleteOrderBloc.dart';
import '../models/OrdersDataModel.dart';

class OrderListScreen extends StatefulWidget {
  String endPOint;
  String title;

  OrderListScreen(this.endPOint, this.title, {Key? key}) : super(key: key);

  @override
  OrderListScreenState createState() => OrderListScreenState();
}

class OrderListScreenState extends State<OrderListScreen> {
  List<OrdersDataModel> OrdersList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userDataModel.data != null) {
      if (widget.endPOint == pending) {
        blocPending.fetchAllPendingOrders(userDataModel.data!.id.toString());
      } else if (widget.endPOint == process) {
        blocProcess.fetchAllProcessOrders(userDataModel.data!.id.toString());
      } else if (widget.endPOint == complete) {
        blocComplete.fetchAllCompleteOrders(userDataModel.data!.id.toString());
      } else {
        blocOrders.fetchAllOrders(userDataModel.data!.id.toString());
      }
    }
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 0.0, right: 10.0, top: 10.0),
        child: StreamBuilder(
          stream: widget.endPOint == pending
              ? blocPending.allPendingOrders
              : widget.endPOint == process
                  ? blocProcess.allProcessOrders
                  : widget.endPOint == complete
                      ? blocComplete.allCompleteOrders
                      : blocOrders.allOrders,
          builder: (context, AsyncSnapshot<List<OrdersDataModel>> snapshot) {
            if (snapshot.hasData) {
              OrdersList = snapshot.data!;
              return AddListView();
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
              child: loadingColor(mainColor, 25.0, 25.0),
            );
          },
        ),
      ),
    );
  }

  Widget AddListView() {
    return ListView.builder(
      itemCount: OrdersList.length,
      itemBuilder: (BuildContext context, int index) {
        var data = OrdersList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailsScreen(ordersModel: data, title: widget.title),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: mainColor,
                    child: Image.asset(
                      widget.title == pendingOrdersStr
                          ? imagePath + "ic_pending.png"
                          : widget.title == processOrdersStr
                              ? imagePath + "ic_process.png"
                              : widget.title == completeOrdersStr
                                  ? imagePath + "ic_complete.png"
                                  : imagePath + "ic_pending.png",
                      width: 30,
                      height: 30,
                      color: whiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        data.name.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Order id :- #${data.orderId}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Mobile :- ${data.customerPhone.toString()}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Pick up :- ${data.packupAddress.toString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Drop :- ${data.dropAddress.toString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      data.isLoading
                          ? loadingColor(mainColor, 18.0, 18.0)
                          : InkWell(
                              onTap: () async {
                                if (widget.title == orderList) {
                                  setState(() {
                                    data.isLoading = true;
                                  });
                                  int code = await Repository()
                                      .approveOrder(data.id, yes);
                                  setState(() {
                                    data.isLoading = false;
                                  });
                                  if (code == 200) {
                                    Navigator.pop(context);
                                    RefreshData();
                                    ShowToast(orderAccepted, context);
                                  }
                                } else if (widget.title == processOrdersStr) {
                                  setState(() {
                                    data.isLoading = true;
                                  });
                                  int code = await Repository()
                                      .changeOrder(data.id, complete);
                                  setState(() {
                                    data.isLoading = false;
                                  });
                                  if (code == 200) {
                                    Navigator.pop(context);
                                    RefreshData();
                                    ShowToast(orderCompleted, context);
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: mainColor,
                                ),
                                child: Center(
                                  child: Text(
                                    widget.title == pendingOrdersStr
                                        ? 'PENDING'
                                        : widget.title == processOrdersStr
                                            ? 'FINISH'
                                            : widget.title == completeOrdersStr
                                                ? 'COMPLETED'
                                                : "ACCEPT",
                                    style: const TextStyle(
                                        color: whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        width: widget.title == "Order List" ||
                                widget.title == "Process Orders"
                            ? 7
                            : 0,
                      ),
                      widget.title == "Order List" ||
                              widget.title == "Process Orders"
                          ? Text(
                              widget.title == "Process Orders"
                                  ? 'Process'
                                  : 'DECLINE',
                              style: const TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> ChangeStatus(String status, String order_id) async {
    var response = await http.post(Uri.parse("${baseurl}approve"), body: {
      "id": order_id,
      "status": "yes",
    });

    var data = json.decode(response.body);
    if (data['code'] == 200) {
      ShowToast("Order Accepted", context);
      Navigator.pop(context);
    }
  }

  Future<void> ChangeStatusofProcess(String status, String order_id) async {
    var response = await http.post(Uri.parse("${baseurl}status"), body: {
      "id": order_id,
      "status": "complete",
    });
    var data = json.decode(response.body);
    if (data['code'] == 200) {
      ShowToast("Order Completed", context);
      Navigator.pop(context);
    }
  }

  void RefreshData() {
    /*  if (userDataModel.data != null) {
      bloc.fetchAllTotalOrders(userDataModel.data!.id.toString());
      blocTodayOrders.fetchAllTodayOrder(userDataModel.data!.id.toString());
      blocPending.fetchAllPendingOrders(userDataModel.data!.id.toString());
      blocProcess.fetchAllProcessOrders(userDataModel.data!.id.toString());
      blocComplete.fetchAllCompleteOrders(userDataModel.data!.id.toString());
    }*/
  }
}
/*Card(
                  child: ListTile(
                    subtitle: Column(
                      children: <Widget>[
                        Container(
                            child: Row(
                          children: <Widget>[
                            FlatButton(
                              color: Colors.green,
                              textColor: Colors.white,
                              child: const Text("Accept"),
                              onPressed: () {},
                            ),
                            FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              child: const Text("Deny"),
                              onPressed: () {},
                            ),
                          ],
                        ))
                      ],
                    ),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      'order id: #${data.name}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        EnterExitRoute(
                          exitPage: Order(widget.endPOint, widget.title),
                          enterPage: Details(student: data),
                        ),
                      );
                    },
                  ),
                )*/
