import 'package:air1906_flutter/models/Resource.dart';
import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../models/ResourceInstance.dart';
import '../viewModel/InstanceTagsViewModel.dart';

class InstanceTagsScreen extends StatelessWidget {
  static const routeName = "/instanceTags";
  final InstanceTagsViewModel _instanceTagsViewModel = InstanceTagsViewModel();
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
                      'Zapiši instancu u NFC Tag',
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
                      stream: _instanceTagsViewModel.instancesWithoutTags,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if ((snapshot.data as List<ResourceInstance>).length == 0) {
                          return Center(
                            child: Text(
                              "Nema dostupnih instanci",
                            ),
                          );
                        } else if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: (snapshot.data as List<ResourceInstance>)
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
              Future.delayed(Duration(seconds: 1)).then((x) {
                Navigator.of(context).pop();
              });
            }
          } 
          return Card(
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

  void showNFCDialog(BuildContext context) {
    EasyDialog(
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
        ]).show(context);
  }
}
