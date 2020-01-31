import 'package:air1906_flutter/models/Category.dart';
import 'package:air1906_flutter/viewModel/CategoryResourcesViewModel.dart';
import 'package:air1906_flutter/widgets/CategoryItem.dart';
import 'package:air1906_flutter/widgets/ResourceItem.dart';

import 'package:flutter/material.dart';
import '../widgets/MyResourceItem.dart';
import '../viewModel/SearchResourceViewModel.dart';
import '../models/Resource.dart';

import '../viewModel/CategoriesViewModel.dart';

class SearchResourceScreen extends StatelessWidget {
  static const routeName = "/searchResource";
  final SearchResourceViewModel _searchResourceViewModel =
      SearchResourceViewModel();

  final CategoriesViewModel _categoriesViewModel = CategoriesViewModel();

  List<String> categoriesList;

  List<DropdownMenuItem<String>> dropDownBuilder(
      AsyncSnapshot<dynamic> snapshot) {
    List<DropdownMenuItem<String>> listCategoriesName;
    listCategoriesName =
        (snapshot.data['categoryList'] as List<Category>).map((Category value) {
      return new DropdownMenuItem<String>(
        value: value.naziv,
        child: new Text(value.naziv),
      );
    }).toList();
    listCategoriesName.add(DropdownMenuItem<String>(
      value: 'Sve',
      child: new Text('Sve'),
    ));
    return listCategoriesName;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Row(
                children: <Widget>[
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: TextField(
                          decoration: InputDecoration(
                              hintText: "Pretraga", fillColor: Colors.white),
                          onChanged: (value) {
                            _searchResourceViewModel.onSearchTextChange(value);
                            _searchResourceViewModel.refreshScreen();
                          }),
                    ),
                  ),
                  IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height - 74,
              width: MediaQuery.of(context).size.width - 0.1,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    35,
                  ),
                  topRight: Radius.circular(
                    35,
                  ),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 40,
                          child: StreamBuilder(
                              stream:
                                  _searchResourceViewModel.enabledButtonSlobdno,
                              builder: (context, snapshot) {
                                return FlatButton(
                                    color: (snapshot.data as bool)
                                        ? Colors.black
                                        : Colors.white,
                                    shape: new RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.black, width: 2),
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Slobodno',
                                          style: TextStyle(
                                              color: snapshot.data
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            disabledColor: snapshot.data
                                                ? Colors.white
                                                : Colors.black,
                                            icon: snapshot.data
                                                ? Icon(Icons.check)
                                                : Icon(Icons.close),
                                            iconSize: 20,
                                            onPressed: null,
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      _searchResourceViewModel
                                          .toggleAvailableButton();
                                      _searchResourceViewModel.refreshScreen();
                                    });
                              }),
                        ),
                        Container(
                          width: 122,
                          height: 40,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(30.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: StreamBuilder(
                                  stream: _categoriesViewModel
                                      .observableCategoryMap,
                                  builder: (context, snapshot) {
                                    return new DropdownButton<String>(
                                      iconEnabledColor: Colors.black,
                                      hint: Text(
                                        snapshot.data['categoryName'] as String,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      items: dropDownBuilder(snapshot),
                                      onChanged: (value) {
                                        _categoriesViewModel
                                            .onChangedDropDownMenu(value);
                                        _searchResourceViewModel
                                            .getAllResourceByCategory(value);
                                        _searchResourceViewModel
                                            .refreshScreen();
                                      },
                                    );
                                  }),
                            ),
                          ),
                        )
                      ]),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: StreamBuilder(
                        stream: _searchResourceViewModel.observableResourceList,
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
                              itemCount:
                                  (snapshot.data as List<Resource>).length,
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
          ],
        ),
      ),
    );
  }
}
