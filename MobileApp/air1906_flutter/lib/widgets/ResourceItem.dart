import 'package:flutter/material.dart';

import '../models/Resource.dart';
import '../screens/ResourceDetailScreen.dart';

class ResourceItem extends StatelessWidget {
  final Resource resource;
  ResourceItem(this.resource);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ResourceDetailScreen.routeName, arguments: resource);
      },
      child: Hero(
          tag: resource.id,
          child: Card(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            child: ListTile(
              title: Text(resource.naziv),
              leading:
                  CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
              subtitle: Text(
                  "Posudba traje ${resource.maxVrijemePosudbe.inDays} dana"),
              trailing: Container(
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: resource.kolicina > 0
                        ? Colors.green[300]
                        : Colors.red[300],
                    child: Text(
                      resource.kolicina.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          )
          // child: ListTile(
          //   title: Text(resource.naziv),
          //   leading: CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
          //   subtitle:
          //       Text("Posudba traje ${resource.maxVrijemePosudbe.inDays} dana"),
          //   trailing: Container(
          //       width: 100,
          //       child: CircleAvatar(
          //         backgroundColor:
          //             resource.kolicina > 0 ? Colors.green[300] : Colors.red[300],
          //         child: Text(
          //           resource.kolicina.toString(),
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       )),
          // ),
          ),
    );
  }
}
