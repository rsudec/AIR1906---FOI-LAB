import 'package:air1906_flutter/nfc/NFCLoader.dart';

import '../interface/IResourceLoader.dart';
import '../viewModel/BorrowViewModel.dart';
import 'package:flutter/material.dart';
import '../helpers/Modules.dart';

class BorrowScreen extends StatelessWidget {
  static const routeName = "/borrow";
  NFCType type;
  final borrowViewModel = BorrowViewModel();
  BorrowScreen();
  @override
  Widget build(BuildContext context) {
    type = ModalRoute.of(context).settings.arguments as NFCType;
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
                      type == NFCType.borrowResource
                          ? 'Posudi resurs'
                          : 'Vrati resurs',
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
                  height: MediaQuery.of(context).size.height,
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
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: StreamBuilder(
                            stream: borrowViewModel.observableLoaderList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: Modules.modules.length,
                                  itemBuilder: (context, item) {
                                    Modules.modules[item].context = context;
                                    return ResourceLoaderItem(
                                        Modules.modules[item],
                                        borrowViewModel,
                                        type);
                                  },
                                );
                              } else {
                                return Center(child: Text("Error"));
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 150,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    child: StreamBuilder(
                        stream: borrowViewModel.observableBorrowMessage,
                        builder: (context, snapshot) {
                          return Align(
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 10,
                                color: Colors.white,
                                child: Container(
                                    width: 300,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        snapshot.hasError
                                            ? FittedBox(
                                                alignment: Alignment.center,
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  snapshot.error,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      color: Colors.red[400]),
                                                ),
                                              )
                                            : Container(),
                                        snapshot.hasData
                                            ? Text(snapshot.data,
                                                style: TextStyle(
                                                    fontSize: 26,
                                                    color: Colors.green[400]))
                                            : Container(),
                                      ],
                                    )),
                              ));
                        }),
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

class ResourceLoaderItem extends StatelessWidget {
  final IResourceLoader item;
  final NFCType type;
  final BorrowViewModel borrowViewModel;
  ResourceLoaderItem(this.item, this.borrowViewModel, this.type);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String id = await item.loadResource().then((x) {
          return x;
        });
        print("id $id");
        type == NFCType.borrowResource
            ? borrowViewModel.borrowResource(id)
            : borrowViewModel.returnResource(id);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                item.title,
                style: TextStyle(fontSize: 34),
              ),
              Expanded(child: Container()),
              CircleAvatar(
                child: item.icon,
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
