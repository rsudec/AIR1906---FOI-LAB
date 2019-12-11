import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:air1906_flutter/models/APIResponse.dart';
import 'package:air1906_flutter/models/Resource.dart';
import 'package:air1906_flutter/widgets/ResourceItem.dart';
import 'package:flutter/material.dart';

import '../widgets/AppDrawerMenu.dart';

import '../service/ResourceService.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var service = ResourceService();

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void _toggle(InnerDrawerDirection direction) {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: direction);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InnerDrawer(
        key: _innerDrawerKey,
        swipe: true,
        onTapClose: true,
        borderRadius: 20,
        //offset: IDOffset.only(bottom: 0.5),
        scale: IDOffset.horizontal(0.9),
        leftChild: AppDrawerMenu(),
        
        //rightChild: Container(),
        scaffold: Scaffold(
          appBar: AppBar(
            title: Text(
              "Dobrodošli",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                _toggle(InnerDrawerDirection.start);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  //_toggle(InnerDrawerDirection.end);
                },
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: FutureBuilder(
            future: service.getResourceList(),
            builder: (ctx, dataSnaphot) {
              if (dataSnaphot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (dataSnaphot.error != null) {
                return Center(child: Text("Error"));
              } else {
                //print(dataSnaphot);
                APIResponse<List<Resource>> res = dataSnaphot.data;
                //print(res.data);

                return ListView.builder(
                  itemCount: res.data.length,
                  itemBuilder: (ctx, i) => ResourceItem(res.data[i]),
                );
              }
            },
          ),
          // CustomScrollView(
          //   slivers: <Widget>[
          //     SliverAppBar(
          //       backgroundColor: Colors.black,
          //       elevation: 0,
          //       expandedHeight: 200,
          //       pinned: true,
          //       flexibleSpace: FlexibleSpaceBar(
          //         title: Text("Dobrodošli."),
          //         background: Hero(
          //           tag: "2",
          //           child: Container(
          //             decoration: BoxDecoration(
          //               color: Colors.black,
          //               borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(40),
          //                 bottomRight: Radius.circular(40),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //     SliverList(
          //       delegate: SliverChildListDelegate([
          //         SizedBox(
          //           height: 2000,
          //         ),
          //       ]),
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
