import 'dart:convert';

import 'package:deliveryapp/res/ResColor.dart';
import 'package:deliveryapp/src/bloc/CompleteOrderBloc.dart';
import 'package:deliveryapp/src/bloc/PendingOrderBloc.dart';
import 'package:deliveryapp/src/bloc/ProcessOrderBloc.dart';
import 'package:deliveryapp/src/bloc/TodayOrderBloc.dart';
import 'package:deliveryapp/src/models/UserDataModel.dart';
import 'package:deliveryapp/utils/LocalStorageName.dart';
import 'package:deliveryapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import '../../apiservice/EndPoints.dart';
import '../../res/ResString.dart';
import '../bloc/TotalOrderBloc.dart';
import '../models/OrdersDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'OrderListScreen.dart';
import 'setting.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardScreen> {
  var email;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userDataModel = UserDataModel.fromJson(
          json.decode(prefs.getString(loginUser).toString()));
    });
    // Or call your function here
  }

  @override
  Widget build(BuildContext context) {
    if (userDataModel.data != null) {
      bloc.fetchAllTotalOrders(userDataModel.data!.id.toString());
      blocTodayOrders.fetchAllTodayOrder(userDataModel.data!.id.toString());
      blocPending.fetchAllPendingOrders(userDataModel.data!.id.toString());
      blocProcess.fetchAllProcessOrders(userDataModel.data!.id.toString());
      blocComplete.fetchAllCompleteOrders(userDataModel.data!.id.toString());
    }
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        /*  IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {},
        ),*/
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {},
        )
      ], backgroundColor: mainColor, title: const Text('Dashboard')),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: const Color(0xffb1acc8d),
                            borderRadius: BorderRadius.circular(
                              15,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: bloc.allOrders,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.toString(),
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.white));
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return loadingColor(whiteColor, 22.0, 22.0);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            const Text("Total Order",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: poppins_medium)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: blueColor,
                            borderRadius: BorderRadius.circular(
                              15,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder(
                              stream: blocTodayOrders.alltodayOrders,
                              builder:
                                  (context, AsyncSnapshot<String> snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data.toString(),
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.white));
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return loadingColor(whiteColor, 22.0, 22.0);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Today Order",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontFamily: poppins_medium)),
                          ],
                        ),
                      ),
                    ),
                  ])),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderListScreen(pending, pendingOrdersStr),
                        ),
                      );
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: blueColor),
                                    ),
                                    Spacer(),
                                    StreamBuilder(
                                      stream: blocPending.allPendingOrders,
                                      builder: (context,
                                          AsyncSnapshot<List<OrdersDataModel>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return SizedBox(
                                            width: 23,
                                            height: 23,
                                            child: CircleAvatar(
                                              backgroundColor: mainColor,
                                              child: Text(
                                                snapshot.data!.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 11,
                                                    fontFamily: poppins_medium),
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                        return loadingColor(
                                            blueColor, 20.0, 20.0);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        imagePath + "ic_pending.png",
                                        width: 70,
                                        height: 70,
                                        color: greyColor2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        pendingOrdersStr,
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 15,
                                            fontFamily: poppins_medium),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            new BoxShadow(
                              color: greyColor3,
                              blurRadius: 20.0,
                            ),
                          ],
                        )),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OrderListScreen(process, processOrdersStr),
                        ),
                      );
                    },
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: pinkColor),
                                    ),
                                    Spacer(),
                                    StreamBuilder(
                                      stream: blocProcess.allProcessOrders,
                                      builder: (context,
                                          AsyncSnapshot<List<OrdersDataModel>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return SizedBox(
                                            width: 23,
                                            height: 23,
                                            child: CircleAvatar(
                                              backgroundColor: mainColor,
                                              child: Text(
                                                snapshot.data!.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color: whiteColor,
                                                    fontSize: 11,
                                                    fontFamily: poppins_medium),
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                        return loadingColor(
                                            pinkColor, 20.0, 20.0);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        imagePath + "ic_process.png",
                                        width: 70,
                                        height: 70,
                                        color: greyColor2,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        processOrdersStr,
                                        style: TextStyle(
                                            color: greyColor,
                                            fontSize: 15,
                                            fontFamily: poppins_medium),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            new BoxShadow(
                              color: greyColor3,
                              blurRadius: 20.0,
                            ),
                          ],
                        )),
                  )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderListScreen(complete, completeOrdersStr),
                          ),
                        );
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 3,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: greenColor),
                                      ),
                                      Spacer(),
                                      StreamBuilder(
                                        stream: blocComplete.allCompleteOrders,
                                        builder: (context,
                                            AsyncSnapshot<List<OrdersDataModel>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return SizedBox(
                                              width: 23,
                                              height: 23,
                                              child: CircleAvatar(
                                                backgroundColor: mainColor,
                                                child: Text(
                                                  snapshot.data!.length
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontSize: 11,
                                                      fontFamily:
                                                          poppins_medium),
                                                ),
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          }
                                          return loadingColor(
                                              greenColor, 20.0, 20.0);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          imagePath + "ic_complete.png",
                                          width: 70,
                                          height: 70,
                                          color: greyColor2,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          completeOrdersStr,
                                          style: TextStyle(
                                              color: greyColor,
                                              fontSize: 15,
                                              fontFamily: poppins_medium),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              new BoxShadow(
                                color: greyColor3,
                                blurRadius: 20.0,
                              ),
                            ],
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ],
          ))
        ],
      )),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xffbfd7e14),
              ),
              accountName: Text(userDataModel.data != null
                  ? userDataModel.data!.name.toString()
                  : ""),
              accountEmail: Text(userDataModel.data != null
                  ? userDataModel.data!.email.toString()
                  : ""),
              currentAccountPicture: SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  foregroundImage: userDataModel.data != null
                      ? userDataModel.data!.profile != null
                          ? NetworkImage(userDataModel.data!.profile.toString())
                          : null
                      : null,
                  backgroundColor: Colors.blue,
                  child: userDataModel.data != null
                      ? userDataModel.data!.profile == null
                          ? Text(
                              userDataModel.data!.name![0],
                              style: TextStyle(fontSize: 40.0),
                            )
                          : Container()
                      : Container(),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text("Orders"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderListScreen(orders, orderList),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: const Text("Setting"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                Navigator.pop(context);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
