import 'package:air1906_flutter/widgets/bezierContainer.dart';
import 'package:flutter/material.dart';
import '../widgets/MyResourceItem.dart';
import '../models/ResourceInstance.dart';
import '../viewModel/MyResourceViewModel.dart';

class MyResourcesScreen extends StatelessWidget {
  static const routeName = "/myResources";
  final MyResourceViewModel _myResourceViewModel = MyResourceViewModel();

  // void _unesiNapomenu(String napomena) {
  //   _myResourceViewModel.insertCommentByUser(Auth.currentUser, napomena);
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(233, 233, 235, 0.9),
          body: Stack(
            children: <Widget>[
              Positioned(
                bottom: -MediaQuery.of(context).size.height * .15,
                right: -MediaQuery.of(context).size.width * .4,
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
                                  'My resources list',
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
                                    _myResourceViewModel.observableResourceList,
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
                                      itemCount: (snapshot.data
                                              as List<ResourceInstance>)
                                          .length,
                                      itemBuilder: (ctx, i) => MyResourceItem(
                                          snapshot.data[i],
                                          _myResourceViewModel),
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
