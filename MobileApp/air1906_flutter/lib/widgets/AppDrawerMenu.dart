import 'package:flutter/material.dart';
import '../service/LoginService.dart';
import '../screens/loginScreen.dart';

class AppDrawerMenu extends StatelessWidget {
  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          "https://justice.org.au/wp-content/uploads/2017/08/avatar-icon.png"),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Korisnik",
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        Text(
                          "email@adresa.com",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Theme.of(context).disabledColor,
                  thickness: 2,
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.home,
                            size: 35,
                          ),
                          selected: true,
                          title: Text(
                            "Početna",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.search,
                            size: 35,
                          ),
                          title: Text(
                            "Pretraga",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            size: 35,
                          ),
                          title: Text(
                            "Postavke",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.info,
                            size: 35,
                          ),
                          title: Text(
                            "O aplikaciji",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            loginService.logout();
                            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                          },
                          leading: Icon(
                            Icons.arrow_back,
                            size: 35,
                          ),
                          title: Text(
                            "Odjava",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
