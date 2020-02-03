// import 'dart:html';

import 'package:air1906_flutter/models/MyContainer.dart';
import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:air1906_flutter/viewModel/DetailScreenViewModel.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import '../models/Resource.dart';

class ResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resourceDetail';
  ResourceService rs = ResourceService();
  DetailScreenViewModel _detailScreenViewModel = DetailScreenViewModel();
  @override
  Widget build(BuildContext context) {
    final loadedResource =
        ModalRoute.of(context).settings.arguments as Resource;
    _detailScreenViewModel.getResourceContainers(loadedResource.id);

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfffbb448), Color(0xffe46b10)]),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              elevation: 10,
              leading: Container(
                margin: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50),
                //     color: Colors.black26),
                child: IconButton(
                  color: Colors.orange,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              expandedHeight: 300,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                //title: Container(width: double.infinity,color: Colors.black45, child: Text(loadedResource.naziv,)),
                background: Hero(
                  tag: loadedResource.id,
                  child: Image.network(loadedResource.imgUrl),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 20,
                ),
                Text(
                  loadedResource.naziv,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 3,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 40,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child:
                                  Text("Currently available: ".toUpperCase())),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                (loadedResource.kolicina).toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Max loan period (in days): ".toUpperCase(),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                (loadedResource.maxVrijemePosudbe.inDays)
                                    .toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Where can I find this resource",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                StreamBuilder(
                  stream: _detailScreenViewModel.observableContainerList,
                  builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as List<List<MyContainer>>;
                      if (data.length == 0) {
                        return Center(child: Text("No information"));
                      }
                      if (data.length > 1) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          height: 250,
                          decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.2), ) ,
                          width: MediaQuery.of(context).size.width - 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.length,
                              itemBuilder: (ctx, x) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                    height: 300,
                                    width: 250,
                                    child: Timeline.builder(
                                      reverse: false,
                                      itemCount: data[x].length,
                                      position: TimelinePosition.Left,
                                      itemBuilder: (context, y) {
                                        return TimelineModel(
                                          Container(
                                            height: 50,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 30),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Card(
                                                elevation: 5,
                                                child: Padding(
                                                  padding: EdgeInsets.all(7),
                                                  child: Text(
                                                    data[x][y].naziv,
                                                    style: TextStyle(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          position: TimelineItemPosition.right,
                                          iconBackground: Colors.redAccent,
                                          icon: Icon(
                                              Icons.check_box_outline_blank),
                                        );
                                      },
                                    ),
                                  )),
                        );
                      } else if (data.length == 1)
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          height: 300,
                          width: 500,
                          child: Align(
                            alignment: Alignment.center,
                            child: Timeline.builder(
                              reverse: false,
                              itemCount: data[0].length,
                              position: TimelinePosition.Center,
                              itemBuilder: (context, i) {
                                return TimelineModel(
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.symmetric(vertical: 30),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: EdgeInsets.all(7),
                                          child: Text(
                                            data[0][i].naziv,
                                            style: TextStyle(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  position: TimelineItemPosition.random,
                                  iconBackground: Colors.redAccent,
                                  icon: Icon(Icons.check_box_outline_blank),
                                );
                              },
                            ),
                          ),
                        );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Divider(
                  thickness: 3,
                  indent: 50,
                  endIndent: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 40,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
