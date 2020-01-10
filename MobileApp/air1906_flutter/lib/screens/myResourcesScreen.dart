import 'package:flutter/material.dart';
import '../widgets/MyResourceItem.dart';
import '../models/Resource.dart';
import '../viewModel/MyResourceViewModel.dart';

class MyResourcesScreen extends StatelessWidget {
  static const routeName = "/myResources";
  final MyResourceViewModel _myResourceViewModel = MyResourceViewModel();

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
                      'Popis mojih resursa',
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
                  height: MediaQuery.of(context).size.height - 85,
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
                      stream: _myResourceViewModel.observableResourceList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Nema dostupnih resursa"));
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: (snapshot.data as List<Resource>).length,
                            itemBuilder: (ctx, i) =>
                                MyResourceItem(snapshot.data[i]),
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
          ],
        ),
      ),
    );
  }
}
