import 'package:air1906_flutter/models/Resource.dart';
import 'package:air1906_flutter/screens/SplashScreen.dart';
import 'package:air1906_flutter/viewModel/CategoryResourcesViewModel.dart';
import 'package:flutter/material.dart';

import '../models/Category.dart';
import '../screens/CategoryResourceScreen.dart';
import 'ResourceItem.dart';
import 'mainResourceItem.dart';

class CategoryItem extends StatelessWidget {
  Category category;

  CategoryResourceViewModel _categoryResourceViewModel;

  CategoryItem(Category category) {
    this.category = category;
    this._categoryResourceViewModel = CategoryResourceViewModel(category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromRGBO(255, 255, 255, 0.8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  category.naziv.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryResourceScreen(category)));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Text(
                    "VIEW ALL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 138,
            child: StreamBuilder(
              stream: _categoryResourceViewModel.observableResourceList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("There are no avaliable items"));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (snapshot.data as List<Resource>).length,
                    itemBuilder: (ctx, i) => MainResourceItem(snapshot.data[i]),
                  );
                }
                return Center(
                  child: Text("Error"),
                );
              },
            ),
          )
        ],
      ),
    );

    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryResourceScreen(category)));
    //     },
    //     child: GridTile(
    //       child: Container(
    //         padding: EdgeInsets.all(5),
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //           border: Border.all(width: 1),
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               Text(
    //                 category.naziv,
    //                 style: TextStyle(
    //                   fontSize: 28,
    //                   color: Colors.black,
    //                   fontFamily: 'Montserrat',
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
