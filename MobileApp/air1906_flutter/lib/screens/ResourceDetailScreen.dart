import 'package:flutter/material.dart';
import '../models/Resource.dart';

class ResourceDetailScreen extends StatelessWidget {
  static const routeName = '/resourceDetail';

  @override
  Widget build(BuildContext context) {
    final loadedResource =
        ModalRoute.of(context).settings.arguments as Resource;
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black26),
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Text(
              loadedResource.naziv,
            ),
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              //title: Container(width: double.infinity,color: Colors.black45, child: Text(loadedResource.naziv,)),
              background: Hero(
                tag: loadedResource.id,
                child: Image.network(loadedResource.imgUrl, fit: BoxFit.cover),
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
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Informacije o artiklu",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                padding: EdgeInsets.all(10),
                child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                decoration: BoxDecoration(
                  //color: Theme.of(context).primaryColorDark,
                  border: Border.all(
                      color: Theme.of(context).primaryColorDark, width: 3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Divider(
                thickness: 3,
                indent: 50,
                endIndent: 50,
                color: Theme.of(context).primaryColorDark,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(5),
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColorDark),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FittedBox(
                              child: Text(
                            "Dostupno:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          )),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              loadedResource.kolicina.toString(),
                              style: TextStyle(
                                  fontSize: 34,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            radius: 40,
                          ),
                          FittedBox(
                              child: Text(
                            "komada",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          )),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.all(5),
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColorDark),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FittedBox(
                              child: Text(
                            "Posudi na:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w700),
                          )),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Text(
                              loadedResource.maxVrijemePosudbe.inDays
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 34,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                            radius: 40,
                          ),
                          FittedBox(
                              child: Text(
                            "dana",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          )),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
