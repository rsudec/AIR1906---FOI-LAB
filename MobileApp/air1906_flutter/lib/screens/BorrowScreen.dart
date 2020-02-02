import 'dart:io';

import '../models/ResourceInstance.dart';
import '../widgets/BezierContainer.dart';
import 'package:easy_dialog/easy_dialog.dart';

import '../interface/IResourceLoader.dart';
import '../viewModel/BorrowViewModel.dart';
import 'package:flutter/material.dart';
import '../helpers/Modules.dart';

class BorrowScreen extends StatelessWidget {
  static const routeName = "/borrow";
  ResourceLoaderType type;
  final borrowViewModel = BorrowViewModel();
  //BorrowScreen();
  @override
  Widget build(BuildContext context) {
    type = ModalRoute.of(context).settings.arguments as ResourceLoaderType;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
        body: Stack(
          children: <Widget>[
            Positioned(
              bottom: MediaQuery.of(context).size.height * .05,
              left: MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.8),
                        child: IconButton(
                          color: Colors.black,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          type == ResourceLoaderType.borrowResource
                              ? 'Borrow resource'
                              : 'Return resource',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Opacity(
                        opacity: 0,
                        child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.arrow_back),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
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
              ],
            ),
            StreamBuilder(
              stream: borrowViewModel.observableBorrowMessage,
              builder: (context, snapshot) {
                if (snapshot.data == "" || snapshot.error == "")
                  return Container();
                else
                  return Positioned(
                    bottom: 150,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      child: Align(
                        alignment: Alignment.center,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          color: Colors.white,
                          child: Container(
                            width: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                snapshot.hasError
                                    ? Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(
                                          " ${snapshot.error}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 26,
                                              color: Colors.red[400]),
                                        ),
                                      )
                                    : Container(),
                                snapshot.hasData
                                    ? Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(snapshot.data,
                                            style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.green[400])),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ResourceLoaderItem extends StatelessWidget {
  final IResourceLoader item;
  final ResourceLoaderType type;
  final BorrowViewModel borrowViewModel;
  ResourceLoaderItem(this.item, this.borrowViewModel, this.type);

  void _takeAction(String id) {
    type == ResourceLoaderType.borrowResource
        ? borrowViewModel.borrowResource(id)
        : borrowViewModel.returnResource(id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String id = await item.loadResource().then((x) {
          return x;
        });
        if (id != null && id != "-1") {
          await borrowViewModel.checkResourceType(id);
          EasyDialog(
              height: MediaQuery.of(context).size.height / 1.5,
              cornerRadius: 15,
              cardColor: Colors.white,
              contentList: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                    stream: borrowViewModel.instanceName,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        ResourceInstance instance = snapshot.data;
                        return Text(
                          type == ResourceLoaderType.borrowResource
                              ? "Confirm borrowing instance of ${instance.resource.naziv} ?"
                              : "Confirm returning instance of ${instance.resource.naziv} ?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                Expanded(child: Container()),
                type == ResourceLoaderType.borrowResource
                    ? StreamBuilder(
                        stream: borrowViewModel.obs,
                        builder: (ctx, snapshot) {
                          print(snapshot.data);
                          if (snapshot.hasData) {
                            if (snapshot.data["multiple"] as bool == true) {
                              return Column(
                                children: <Widget>[
                                  Text(
                                    "You've picked resource 'by quantity'. \nPlease specify your desired quantity (max ${snapshot.data['maxQ']})",
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Amount',
                                      ),
                                      onChanged: (val) {
                                        borrowViewModel.wantedResourceQuantity =
                                            val;
                                        borrowViewModel.checkResourceQuantity();
                                      },
                                      keyboardType: Platform.isAndroid
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      textInputAction: TextInputAction.go,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Container();
                          }
                          return Container();
                        },
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    StreamBuilder(
                        stream: borrowViewModel.enabledSubmit,
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              type == ResourceLoaderType.borrowResource) {
                            print(snapshot.data);
                            return FlatButton(
                              color: Colors.green,
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              onPressed: snapshot.data as bool
                                  ? () {
                                      Navigator.of(context).pop();
                                      _takeAction(id);
                                      print("ocuuu");
                                    }
                                  : null,
                            );
                          }
                          return FlatButton(
                            color: Colors.green,
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _takeAction(id);
                              print("ocuuu");
                            },
                          );
                        }),
                    FlatButton(
                      color: Colors.red,
                      child: Text("No",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        print("nikako");
                      },
                    )
                  ],
                )
              ]).show(context);
        }
      },
      child: Card(
        color: Color.fromRGBO(255, 255, 255, 0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
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
                backgroundColor: Colors.orange,
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
