import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';
import '../models/Resource.dart';

class MyResourceItem extends StatelessWidget {
  final Resource resource;
  MyResourceItem(this.resource);

  Widget novaNapomena(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Napomena'),
                onSubmitted: (_) {},
              ),
              RaisedButton(
                child: Text('Dodaj napomenu'),
                color: Colors.black,
                textColor: Colors.white,
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  void _prozorZaNovuNapomenu(BuildContext context) {
    EasyDialog(
        cornerRadius: 15.0,
        fogOpacity: 0.1,
        width: 280,
        height: 180,
        contentPadding:
            EdgeInsets.only(top: 12.0), // Needed for the button design
        contentList: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Napomena",
                  ),
                ),
              )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Unesi",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 1.3,
              ),
            ),
          ),
        ]).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(resource.naziv),
        leading: CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
        subtitle:
            Text("Posudba istiće ${resource.maxVrijemePosudbe.inDays} dana"),
        trailing: Container(
          width: 50,
          child: IconButton(
            icon: Icon(Icons.add_comment),
            color: Colors.black,
            onPressed: () => _prozorZaNovuNapomenu(context),
            //kako prenijeti argument di se ne smije
          ),
        ),
      ),
    );
  }
}
