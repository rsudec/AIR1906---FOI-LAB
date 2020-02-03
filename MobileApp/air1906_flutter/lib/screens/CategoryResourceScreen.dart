import 'package:air1906_flutter/widgets/bezierContainer.dart';
import 'package:flutter/material.dart';
import '../models/Category.dart';
import '../widgets/ResourceItem.dart';
import '../models/Resource.dart';
import '../viewModel/CategoryResourcesViewModel.dart';

class CategoryResourceScreen extends StatelessWidget {
  static const routeName = "/category-resources";
  CategoryResourceViewModel _categoryResourceViewModel;
  Category _currentCategory;
  CategoryResourceScreen(Category current) {
    _currentCategory = current;
    _categoryResourceViewModel = CategoryResourceViewModel(_currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
          body: Stack(
            children: <Widget>[
              Positioned(
                bottom: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 1.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  _currentCategory.naziv,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    letterSpacing: .5,
                                  ),
                                ),
                              ),
                              Opacity(
                                opacity: 0,
                                child: IconButton(
                                  icon: Icon(Icons.dashboard),
                                  onPressed: null,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height - 153,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: StreamBuilder(
                              stream: _categoryResourceViewModel
                                  .observableResourceList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Nema dostupnih resursa"));
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: (snapshot.data as List<Resource>)
                                        .length,
                                    itemBuilder: (ctx, i) =>
                                        ResourceItem(snapshot.data[i]),
                                  );
                                }
                                return Center(
                                  child: Text("Error"),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
          // body: ListView(
          //   children: <Widget>[
          //     Padding(
          //       padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: <Widget>[
          //           IconButton(
          //             color: Colors.white,
          //             icon: Icon(Icons.arrow_back),
          //             onPressed: () {
          //               Navigator.of(context).pop();
          //             },
          //           ),
          //           Expanded(
          //             child: Text(
          //               _currentCategory.naziv,
          //               style: TextStyle(color: Colors.white, fontSize: 24),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //           IconButton(
          //             color: Colors.black,
          //             icon: Icon(Icons.arrow_back),
          //             onPressed: null,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Stack(
          //       children: <Widget>[
          //         Container(color: Colors.white),
          //         Container(
          //           height: MediaQuery.of(context).size.height - 85,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(
          //                 35,
          //               ),
          //               topRight: Radius.circular(
          //                 35,
          //               ),
          //             ),
          //           ),
          //           child: Padding(
          //             padding: EdgeInsets.all(10),
          // child: StreamBuilder(
          //   stream: _categoryResourceViewModel.observableResourceList,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState ==
          //         ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (snapshot.hasError) {
          //       return Center(child: Text("Nema dostupnih resursa"));
          //     } else if (snapshot.hasData) {
          //       return ListView.builder(
          //         itemCount: (snapshot.data as List<Resource>).length,
          //         itemBuilder: (ctx, i) =>
          //             ResourceItem(snapshot.data[i]),
          //       );
          //     }
          //     return Center(
          //       child: Text("Error"),
          //     );
          //   },
          // ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
