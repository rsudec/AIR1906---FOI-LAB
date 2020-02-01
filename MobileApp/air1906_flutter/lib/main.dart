import 'package:air1906_flutter/screens/ResourceDetailScreen.dart';
import './screens/SearchResourceScreen.dart';
import 'package:air1906_flutter/screens/myResourcesScreen.dart';
import './screens/InstanceTagsScreen.dart';
import 'package:flutter/material.dart';
import './screens/BorrowScreen.dart';
import './screens/ResourceDetailScreen.dart';
import './screens/myResourcesScreen.dart';
import './screens/mainScreen.dart';
import './screens/loginScreen.dart';
import './screens/CategoryResourceScreen.dart';
import './helpers/Auth.dart';
import './service/LoginService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final loginService = LoginService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Auth.currentUser != null
          ? MainScreen()
          : FutureBuilder(
              future: loginService.tryAutoLogin(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == true) {
                  return MainScreen();
                }
                return LoginScreen();
              },
            ),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        MainScreen.routeName: (ctx) => MainScreen(),
        CategoryResourceScreen.routeName: (ctx) => CategoryResourceScreen(null),
        ResourceDetailScreen.routeName: (ctx) => ResourceDetailScreen(),
        MyResourcesScreen.routeName: (ctx) => MyResourcesScreen(),
        SearchResourceScreen.routeName: (ctx) => SearchResourceScreen(),
        BorrowScreen.routeName: (ctx) => BorrowScreen(),
        InstanceTagsScreen.routeName: (ctx) => InstanceTagsScreen(),
      },
    );
  }
}
