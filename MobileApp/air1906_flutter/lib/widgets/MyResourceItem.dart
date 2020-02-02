import '../helpers/Auth.dart';

import '../viewModel/MyResourceViewModel.dart';
import 'package:flutter/material.dart';
import 'package:easy_dialog/easy_dialog.dart';
import '../models/ResourceInstance.dart';

class MyResourceItem extends StatelessWidget {
  final ResourceInstance resourceInstance;
  final MyResourceViewModel myResourceViewModel;

  MyResourceItem(this.resourceInstance, this.myResourceViewModel);

  final _napomenaController = TextEditingController();

  void _prozorZaNovuNapomenu(BuildContext context) {
    EasyDialog(
        cornerRadius: 15.0,
        fogOpacity: 0.1,
        width: 280,
        height: 180,
        contentPadding: EdgeInsets.only(
          top: 12.0,
        ), // Needed for the button design
        contentList: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  onChanged: (text) =>
                      myResourceViewModel.onChangeCommentText(text),
                  controller: _napomenaController,
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
                color: Color(0xffe46b10),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0))),
            child: StreamBuilder<bool>(
                stream: myResourceViewModel.enabledButtonSubmit,
                builder: (context, snapshot) {
                  return Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(240, 240, 240, 1.0),
                          border: Border.all(width: 0),
                        ),
                        width: double.infinity,
                        child: snapshot.hasError
                            ? Text(
                                'Poruka je prekratka.',
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              )
                            : Container(),
                      ),
                      FlatButton(
                        onPressed: snapshot.hasData
                            ? snapshot.data
                                ? () {
                                    myResourceViewModel.insertCommentByUser(
                                        Auth.currentUser,
                                        _napomenaController.text,
                                        resourceInstance);
                                    Navigator.of(context).pop();
                                  }
                                : null
                            : null,
                        child: (snapshot.connectionState ==
                                ConnectionState.waiting)
                            ? CircularProgressIndicator()
                            : Text(
                                "Unesi",
                                style: TextStyle(color: Colors.white),
                                textScaleFactor: 1.3,
                              ),
                      ),
                    ],
                  );
                }),
          ),
        ]).show(context);
  }

  @override
  Widget build(BuildContext context) {
    myResourceViewModel.makeExpiredDate(resourceInstance);
    return Card(
      child: ListTile(
        title: Text(
            "${resourceInstance.resource.naziv} [ ${resourceInstance.kolicina} ]"),
        leading: CircleAvatar(
            backgroundImage: NetworkImage(resourceInstance.resource.imgUrl)),
        subtitle: StreamBuilder(
            stream: myResourceViewModel.expiredDate,
            builder: (context, snapshot) {
              return Text("${snapshot.data}");
            }),
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
