import 'package:flutter/material.dart';

import '../models/Resource.dart';
import '../screens/ResourceDetailScreen.dart';

class MainResourceItem extends StatelessWidget {
  final Resource resource;
  MainResourceItem(this.resource);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: FittedBox(
        fit: BoxFit.contain,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ResourceDetailScreen.routeName, arguments: resource);
          },
          borderRadius: BorderRadius.circular(12.5),
          child: Padding(
            padding: EdgeInsets.only(right: 7.5, top: 7.5, left: 7.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  elevation: 7,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22)),
                    child: Hero(
                      tag: resource.id,
                      child: Image(
                        height: MediaQuery.of(context).size.height / 2.8 - 15,
                        width: MediaQuery.of(context).size.height / 2 - 15,
                        image: NetworkImage(resource.imgUrl),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(resource.naziv,
                      style: TextStyle(
                        fontSize: 30,
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );

    // return GestureDetector(
    //   onTap: () {
    //     Navigator.of(context)
    //         .pushNamed(ResourceDetailScreen.routeName, arguments: resource);
    //   },
    //   child: Hero(
    //       tag: resource.id,
    //       child: Card(
    //         child: ListTile(
    //           title: Text(resource.naziv),
    //           leading:
    //               CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
    //           subtitle: Text(
    //               "Posudba traje ${resource.maxVrijemePosudbe.inDays} dana"),
    //           trailing: Container(
    //               width: 100,
    //               child: CircleAvatar(
    //                 backgroundColor: resource.kolicina > 0
    //                     ? Colors.green[300]
    //                     : Colors.red[300],
    //                 child: Text(
    //                   resource.kolicina.toString(),
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //               )),
    //         ),
    //       )

    //       // child: ListTile(
    //       //   title: Text(resource.naziv),
    //       //   leading: CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
    //       //   subtitle:
    //       //       Text("Posudba traje ${resource.maxVrijemePosudbe.inDays} dana"),
    //       //   trailing: Container(
    //       //       width: 100,
    //       //       child: CircleAvatar(
    //       //         backgroundColor:
    //       //             resource.kolicina > 0 ? Colors.green[300] : Colors.red[300],
    //       //         child: Text(
    //       //           resource.kolicina.toString(),
    //       //           style: TextStyle(color: Colors.white),
    //       //         ),
    //       //       )),
    //       // ),
    //       ),
    // );
  }
}
