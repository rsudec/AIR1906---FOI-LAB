import 'package:air1906_flutter/widgets/bezierContainer.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'package:flutter/material.dart';

import '../widgets/AppDrawerMenu.dart';
import '../viewModel/CategoriesViewModel.dart';
import '../models/Category.dart';
import '../widgets/CategoryItem.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';
  final _categoryVM = CategoriesViewModel();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void _toggle(InnerDrawerDirection direction) {
    _innerDrawerKey.currentState.toggle(direction: direction);
  }

  @override
  void dispose() {
    super.dispose();
    widget._categoryVM.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InnerDrawer(
        key: _innerDrawerKey,
        swipe: true,
        onTapClose: true,
        offset: IDOffset.only(bottom: 0.05, left: 0.2),
        borderRadius: 20,
        scale: IDOffset.horizontal(0.9),
        leftChild: AppDrawerMenu(),
        backgroundColor: Color(0xfffbb448),
        scaffold: Scaffold(
          backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 15, left: 10, right: 10),
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _toggle(InnerDrawerDirection.start);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height - 125,
                        child: SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: StreamBuilder(
                                stream:
                                    widget._categoryVM.observableCategoryList,
                                builder: (ctx, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text("Nema dostupnih kategorija"));
                                  } else if (snapshot.hasData) {
                                    print(snapshot.data);
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              125,
                                      child: ListView.builder(
                                        itemCount:
                                            (snapshot.data as List<Category>)
                                                .length,
                                        itemBuilder: (ctx, i) => Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child:
                                                CategoryItem(snapshot.data[i])),
                                      ),
                                    );
                                    //buildCategories(snapshot.data)

                                  }
                                  return Center(
                                    child: Text("Error"),
                                  );
                                },
                              ),
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          //           Padding(
          //             padding: EdgeInsets.only(left: 0.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 Text(
          //                   'AIR',
          //                   style: TextStyle(
          //                     fontFamily: 'Montserrat',
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 25.0,
          //                   ),
          //                 ),
          //                 Text(
          //                   '1906',
          //                   style: TextStyle(
          //                     fontFamily: 'Montserrat',
          //                     color: Colors.white,
          //                     fontSize: 25.0,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 15,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.only(left: 0.0),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: <Widget>[
          //                 Text(
          //                   'Kategorije',
          //                   style: TextStyle(
          //                     fontFamily: 'Montserrat',
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 25.0,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           SizedBox(
          //             height: 40,
          //           ),
          //           Stack(
          //             children: <Widget>[
          //               Container(
          //                 color: Colors.white,
          //               ),
          //               Container(
          //                 height: MediaQuery.of(context).size.height - 220,
          //                 decoration: BoxDecoration(
          //                   color: Colors.white,
          //                   borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(
          //                       35,
          //                     ),
          //                     topRight: Radius.circular(
          //                       35,
          //                     ),
          //                   ),
          //                 ),
          //                 child: Padding(
          //                   padding: EdgeInsets.all(15),
          //                   child: StreamBuilder(
          //                     stream: widget._categoryVM.observableCategoryList,
          //                     builder: (ctx, snapshot) {
          //                       if (snapshot.connectionState ==
          //                           ConnectionState.waiting) {
          //                         return Center(
          //                           child: CircularProgressIndicator(),
          //                         );
          //                       } else if(snapshot.hasError){
          //                         return Center(child: Text("Nema dostupnih kategorija"));
          //                       }else if (snapshot.hasData) {
          //                         //print(snapshot.data);
          //                         return GridView(
          //                           gridDelegate:
          //                               SliverGridDelegateWithFixedCrossAxisCount(
          //                             crossAxisCount: 2,
          //                             childAspectRatio: 1 / 1,
          //                           ),
          //                           children: <Widget>[
          //                             ...buildCategories(snapshot.data)
          //                           ],
          //                           //buildCategories(snapshot.data)
          //                         );
          //                       }
          //                       return Center(
          //                         child: Text("Error"),
          //                       );
          //                     },
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
        ),
      ),
    );
  }

  List<Widget> buildCategories(List<Category> items) {
    List<CategoryItem> categories = List<CategoryItem>();
    items.forEach((category) => categories.add(CategoryItem(category)));
    return categories;
  }
}
