import 'package:deliveryapp/src/ui/vehicle/vehicle.dart';
import 'package:flutter/material.dart';

import 'package:deliveryapp/profile/profile_page.dart';
import 'package:deliveryapp/document/document.dart';
 import 'package:deliveryapp/pic/pic.dart';

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
        appBar: null,
        body: Container(
            margin: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pic(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgSmojUgwjIB87c4Q0hLCAyl__oiTySWGWJUZtUNHlHjBALLzTsu_vMHYMaEwLts4QEoo&usqp=CAU'),
                      backgroundColor: Colors.transparent,
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 20.0, right: 20.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text('Profile info'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );
                          }),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.document_scanner),
                          title: Text('Document info'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Document(),
                              ),
                            );
                          }),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0),
                    child: Card(
                      child: ListTile(
                          leading: Icon(Icons.car_rental),
                          title: Text('Vehicle info'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Vehicle(),
                              ),
                            );
                          }),
                    )),
              ],
            )));
  }
}
