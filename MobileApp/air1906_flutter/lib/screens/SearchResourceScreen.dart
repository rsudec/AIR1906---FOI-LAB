import 'package:air1906_flutter/models/Category.dart';
import 'package:air1906_flutter/viewModel/CategoryResourcesViewModel.dart';
import 'package:air1906_flutter/widgets/CategoryItem.dart';
import 'package:air1906_flutter/widgets/ResourceItem.dart';
import 'package:air1906_flutter/widgets/bezierContainer.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
          body: Stack(
            children: <Widget>[
              Positioned(
                bottom: -MediaQuery.of(context).size.height * .15,
                left: -MediaQuery.of(context).size.width * .4,
                child: BezierContainer(),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
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
                                'Resource search',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.black,
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius: BorderRadius.circular(15)),
                          child: Stack(
                            children: <Widget>[
                              TextField(
                                onChanged: (value) {
                                  _searchResourceViewModel
                                      .onSearchTextChange(value);
                                  _searchResourceViewModel.refreshScreen();
                                },
                                autocorrect: false,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(
                                      top: 13, bottom: 13, left: 15),
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 10,
                                    width: 30,
                                    child: SvgPicture.asset(
                                      "assets/images/discover.svg",
                                      height: 12,
                                      width: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 120,
                            height: 40,
                            child: StreamBuilder(
                                stream: _searchResourceViewModel
                                    .enabledButtonSlobdno,
                                builder: (context, snapshot) {
                                  return FlatButton(
                                      color: (snapshot.data as bool)
                                          ? Colors.black
                                          : Color.fromRGBO(255, 255, 255, 0.8),
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
                                        _searchResourceViewModel
                                            .refreshScreen();
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
                                color: Color.fromRGBO(255, 255, 255, 0.8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: StreamBuilder(
                                    stream: _categoriesViewModel
                                        .observableCategoryMap,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child:
                                                Text("Nema dostupnih resursa"));
                                      }
                                      return new DropdownButton<String>(
                                        iconEnabledColor: Colors.black,
                                        hint: Text(
                                          snapshot.data['categoryName']
                                              as String,
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
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                          child: StreamBuilder(
                            stream:
                                _searchResourceViewModel.observableResourceList,
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
              )
            ],
          )),
    );
  }
}
