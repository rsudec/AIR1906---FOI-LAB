import 'dart:typed_data';

import 'package:air1906_flutter/interface/IResourceLoader.dart';
import 'package:flutter/material.dart';
import '../screens/myResourcesScreen.dart';
import '../service/LoginService.dart';
import '../screens/BorrowScreen.dart';
import '../screens/loginScreen.dart';
import '../helpers/Auth.dart';
import '../nfc/NFCLoader.dart';
import 'package:nfc_manager/nfc_manager.dart';

class AppDrawerMenu extends StatelessWidget {
  final loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40, left: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // CircleAvatar(
                    //   radius: 40,
                    //   backgroundColor: Colors.white,
                    //   backgroundImage: NetworkImage(
                    //       "https://justice.org.au/wp-content/uploads/2017/08/avatar-icon.png"),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            Auth.currentUser.ime,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        // Text(
                        //   Auth.currentUser.prezime,
                        //   style: TextStyle(
                        //       fontFamily: 'Montserrat',
                        //       fontSize: 28,
                        //       fontWeight: FontWeight.bold,
                        //       letterSpacing: 2),
                        // ),
                        Text(
                          Auth.currentUser.email,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Theme.of(context).disabledColor,
                  thickness: 2,
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
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
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(MyResourcesScreen.routeName);
                          },
                          leading: Icon(
                            Icons.archive,
                            size: 35,
                          ),
                          selected: false,
                          title: Text(
                            "Moji resursi",
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
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                BorrowScreen.routeName,
                                arguments: ResourceLoaderType.borrowResource);
                          }
                          // openNFCRead(
                          //   context,
                          //   NFCType.borrowResource,
                          // ),
                          ,
                          leading: Icon(
                            Icons.nfc,
                            size: 35,
                          ),
                          title: Text(
                            "Posudi",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                BorrowScreen.routeName,
                                arguments: ResourceLoaderType.returnResource);
                          },
                          leading: Icon(
                            Icons.nfc,
                            size: 35,
                          ),
                          title: Text(
                            "Vrati",
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
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
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
                        
                        // Auth.currentUser != null
                        //     ? Auth.currentUser.isAdmin()
                        //         ? ListTile(
                        //             onTap: () async {},
                        //             leading: Icon(
                        //               Icons.nfc,
                        //               size: 35,
                        //             ),
                        //             title: Text(
                        //               "Zapiši NFC",
                        //               style: TextStyle(
                        //                 fontFamily: 'Montserrat',
                        //               ),
                        //             ),
                        //           )
                        //         : Container()
                        //     : Container(),
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

  // void openNFCRead(BuildContext context, NFCType type) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => Dialog(
  //       elevation: 10,
  //       child: NFC(type),
  //     ),
  //   );
  // }
}
