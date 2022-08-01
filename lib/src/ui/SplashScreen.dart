import 'package:deliveryapp/src/ui/DashBoardScreen.dart';
import 'package:deliveryapp/src/ui/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/ResColor.dart';
import '../../res/ResString.dart';
import '../../utils/LocalStorageName.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    print("checkFirstSeen");

    Future.delayed(const Duration(milliseconds: 2000), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getBool(isLogin) == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashBoardScreen()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          AnimationLimiter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 2000),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 250.0,
                  child: SlideAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Center(
                    child: Image.asset(
                      '${iconPath}ic_launcher.png',
                      width: 247,
                      height: 157,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
