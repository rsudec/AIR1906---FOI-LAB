
import 'package:flutter/material.dart';
import './screens/mainScreen.dart';
import './screens/loginScreen.dart';
import './screens/CategoryResourceScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        

        home: LoginScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          MainScreen.routeName: (ctx)  => MainScreen(),
          CategoryResourceScreen.routeName: (ctx) => CategoryResourceScreen(null),
        },
    );
  }
}

