import 'package:air1906_flutter/widgets/ResourceItem.dart';
import 'package:air1906_flutter/widgets/SearchResourceItem.dart';
import 'package:flutter/material.dart';
import '../widgets/MyResourceItem.dart';
import '../viewModel/SearchResourceViewModel.dart';
import '../models/Resource.dart';

class SearchResourceScreen extends StatelessWidget {
  static const routeName = "/searchResource";
  final SearchResourceViewModel _searchResourceViewModel =
      SearchResourceViewModel();

  final test = [
    "1",
    "2",
    "3",
  ];

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
                            labelText: "Pretraga", fillColor: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                    color: Colors.white,
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
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 120,
                          height: 40,
                          child: OutlineButton(
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Slobodno',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Expanded(
                                  child: IconButton(
                                    color: Colors.black,
                                    icon: Icon(Icons.close),
                                    iconSize: 20,
                                    onPressed: () {},
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Container(
                          width: 120,
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
                              child: new DropdownButton<String>(
                                iconEnabledColor: Colors.black,
                                hint: Text(
                                  'Kategorija',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                items: <String>['A', 'B', 'C', 'D']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            ),
                          ),
                        )
                      ]),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(top: 50),
                      height: 200,
                      width: 100,
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
                                  SearchResourceItem(snapshot.data[i]),
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
