import 'package:deliveryapp/src/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Document extends StatefulWidget {
  @override
  DocumentState createState() => DocumentState();
}

class DocumentState extends State<Document> {
  late Future<List<Profile>> students;
  final studentListKey = GlobalKey<DocumentState>();

  @override
  void initState() {
    super.initState();
    students = getStudentList();
  }

  Future<List<Profile>> getStudentList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getInt('id');
    final response = await http.get(Uri.parse(
        "https://hytechteam.online/ylt-delivery/public/api/profile/${id}"));

    print(response.body);

    final items = json.decode(response.body).cast<Map<String, dynamic>>();

    List<Profile> students = items.map<Profile>((json) {
      return Profile.fromJson(json);
    }).toList();

    return students;
  }

  void refreshStudentList() {
    setState(() {
      students = getStudentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: studentListKey,
      appBar: null,
      body: Center(
        child: FutureBuilder<List<Profile>>(
          future: students,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();

            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Document Info',
                        style: new TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Upload Driving lincense",
                            style: new TextStyle(
                              fontSize: 18.0,
                            ))),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ButtonTheme(
                          minWidth: 300.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Color(0xffbfd7e14),
                            onPressed: () {},
                            child: Text(
                              "Upload",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text("Upload Id",
                            style: new TextStyle(
                              fontSize: 18.0,
                            ))),
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ButtonTheme(
                          minWidth: 300.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Color(0xffbfd7e14),
                            onPressed: () {},
                            child: Text(
                              "Upload",
                              style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
