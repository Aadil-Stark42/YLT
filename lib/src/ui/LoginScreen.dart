import 'dart:convert';

import 'package:deliveryapp/apiservice/EndPoints.dart';
import 'package:deliveryapp/res/ResColor.dart';
import 'package:deliveryapp/res/ResString.dart';
import 'package:deliveryapp/src/resources/repository.dart';
import 'package:deliveryapp/uicomponent/rounded_input_field.dart';
import 'package:deliveryapp/utils/Constants.dart';
import 'package:deliveryapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String emailStr = "";
  String passwordStr = "";
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 500),
              childAnimationBuilder: (widget) => FadeInAnimation(
                    child: SlideAnimation(
                      child: widget,
                    ),
                  ),
              children: <Widget>[
                Image.asset(iconPath + "ic_launcher.png",
                    width: 150, height: 150, fit: BoxFit.fill),
                SizedBox(
                  height: 30,
                ),
                Text(
                  signinacc,
                  style: TextStyle(fontSize: 16, fontFamily: poppins_medium),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  hintText: Email,
                  onChanged: (value) {
                    emailStr = value.toString();
                  },
                  inputType: TextInputType.emailAddress,
                  icon: Image.asset(
                    "${imagePath}ic_email.png",
                    width: 14,
                    height: 14,
                  ),
                  cornerRadius: 0,
                  horizontalmargin: 5,
                  elevations: 0,
                  borderColor: whiteColor,
                  textAlign: TextAlign.start,
                  verticalmargin: 0,
                  textsize: 14,
                  textcolor: greyColor2,
                  obscureText: false,
                  opTapField: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 3),
                  child: Image.asset(
                    imagePath + "ic_line.png",
                    fit: BoxFit.cover,
                    color: lineColor,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RoundedInputField(
                  hintText: Password,
                  onChanged: (value) {
                    passwordStr = value.toString();
                  },
                  inputType: TextInputType.text,
                  icon: Image.asset(
                    "${imagePath}ic_lock.png",
                    width: 14,
                    height: 14,
                  ),
                  cornerRadius: 0,
                  horizontalmargin: 5,
                  elevations: 0,
                  borderColor: whiteColor,
                  textAlign: TextAlign.start,
                  verticalmargin: 0,
                  textsize: 14,
                  textcolor: greyColor2,
                  obscureText: true,
                  opTapField: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 2, right: 2, top: 3),
                  child: Image.asset(
                    imagePath + "ic_line.png",
                    fit: BoxFit.cover,
                    color: lineColor,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                isloading == false
                    ? InkWell(
                        onTap: () async {
                          if (!isValidEmail(emailStr)) {
                            ShowToast(enterValidEmail, context);
                          } else if (passwordStr.isEmpty) {
                            ShowToast(enterValidPassword, context);
                          } else {
                            setState(() {
                              isloading = true;
                            });
                            hideKeyBoard();
                            await Repository()
                                .loginapi(emailStr, passwordStr, context);
                            setState(() {
                              isloading = false;
                            });
                          }
                        },
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                mainColor,
                                mainColorLight,
                              ])),
                          child: Center(
                            child: Text(
                              login,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 14,
                                  fontFamily: poppins_medium),
                            ),
                          ),
                        ))
                    : loading()
              ]),
        ),
      ),
    );
  }
}
