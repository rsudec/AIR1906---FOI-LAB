import 'dart:async';

import 'package:air1906_flutter/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import '../widgets/bezierContainer.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "/splashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage("assets/images/inventory.png"),
              width: 200,
            ),
          ),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    );
  }
}
