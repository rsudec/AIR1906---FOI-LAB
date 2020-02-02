import 'package:air1906_flutter/widgets/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';

import '../models/ResourceInstance.dart';
import '../viewModel/InstanceTagsViewModel.dart';

class InstanceTagsScreen extends StatelessWidget {
  static const routeName = "/instanceTags";
  final InstanceTagsViewModel _instanceTagsViewModel = InstanceTagsViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
          body: Stack(
            children: <Widget>[
              Positioned(
                top: -MediaQuery.of(context).size.height * .15,
                left: -MediaQuery.of(context).size.width * .4,
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
                                  'Write NFC on resource',
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: MediaQuery.of(context).size.height - 153,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: StreamBuilder(
                                stream:
                                    _instanceTagsViewModel.instancesWithoutTags,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if ((snapshot.data
                                              as List<ResourceInstance>)
                                          .length ==
                                      0) {
                                    return Center(
                                      child: Text(
                                        "Sve instance su zapisane u NFC tagove",
                                      ),
                                    );
                                  } else if (snapshot.hasData) {
                                    return ListView.builder(
                                      itemCount: (snapshot.data
                                              as List<ResourceInstance>)
                                          .length,
                                      itemBuilder: (ctx, i) => InstanceItem(
                                        snapshot.data[i],
                                      ),
                                    );
                                  }
                                  return Center(
                                    child: Text("Error"),
                                  );
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class InstanceItem extends StatelessWidget {
  final ResourceInstance resourceInstance;
  final InstanceTagsViewModel _instanceTagsViewModel = InstanceTagsViewModel();
  InstanceItem(this.resourceInstance);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _instanceTagsViewModel.isWrittenTag,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              // Future.delayed(Duration(seconds: 1)).then((x) {
              Navigator.of(context).pop();
              //_instanceTagsViewModel.stopNFCSession();
              // });
            }
          }
          return Card(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            child: ListTile(
              title: Text(resourceInstance.resource.naziv),
              leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(resourceInstance.resource.imgUrl)),
              subtitle: Text(snapshot.hasData
                  ? snapshot.data == false
                      ? resourceInstance.id
                      : 'Instanca ${resourceInstance.id} je zapisana'
                  : resourceInstance.id),
              trailing: Container(
                width: 50,
                child: IconButton(
                  icon: Icon(Icons.speaker_phone),
                  color: Colors.black,
                  onPressed: snapshot.data == true
                      ? null
                      : () async {
                          showNFCDialog(context);
                          _instanceTagsViewModel
                              .tryWritingTag(resourceInstance.id);
                        },
                ),
              ),
            ),
          );
        });
  }

  Future<void> showNFCDialog(BuildContext context) async {
    print("pred dialog");
    await EasyDialog(
      height: MediaQuery.of(context).size.height / 2,
      cornerRadius: 15,
      cardColor: Colors.white,
      contentList: [
        Text(
          "Zapiši u NFC Tag",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: Image(
            image: AssetImage("assets/images/NFCImage.png"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Prislonite uređaj na NFC oznaku"),
      ],
    ).show(context);
    print("after dialog");
    _instanceTagsViewModel.stopNFCSession();
  }
}
