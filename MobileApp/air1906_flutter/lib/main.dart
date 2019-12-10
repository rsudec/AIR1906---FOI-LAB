
import 'package:flutter/material.dart';
import './screens/mainScreen.dart';
import './screens/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
        routes: {
          MainScreen.routeName: (ctx)  => MainScreen(),
        },
    );
  }
}

