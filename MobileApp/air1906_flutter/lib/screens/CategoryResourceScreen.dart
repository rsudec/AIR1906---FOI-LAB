import 'package:flutter/material.dart';
import '../models/Category.dart';
import '../widgets/ResourceItem.dart';
import '../models/Resource.dart';
import '../viewModel/CategoriesViewModel.dart';

class CategoryResourceScreen extends StatelessWidget {
  static const routeName = "/category-resources";
  final CategoriesViewModel _categoriesViewModel = CategoriesViewModel();
  final Category _currentCategory;
  CategoryResourceScreen(this._currentCategory);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Text(
                      _currentCategory.naziv,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.arrow_back),
                    onPressed: null,
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(color: Colors.white),
                Container(
                  height: MediaQuery.of(context).size.height -85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        35,
                      ),
                      topRight: Radius.circular(
                        35,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: StreamBuilder(
                      stream: _categoriesViewModel.observableCategoryList,
                      builder: (context, streamsnapshot) {
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (ctx, i) => ResourceItem(Resource(i.toString(), "Test $i",0, "https://images.idgesg.net/images/article/2019/10/aceraspire1-100815704-large.jpg", Duration(days: 2))),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
