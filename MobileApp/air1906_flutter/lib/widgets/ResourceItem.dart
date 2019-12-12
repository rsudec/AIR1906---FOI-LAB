import 'package:flutter/material.dart';

import '../models/Resource.dart';

class ResourceItem extends StatelessWidget {

  final Resource resource;
  ResourceItem(this.resource);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(resource.naziv),
      leading: CircleAvatar(backgroundImage: NetworkImage(resource.imgUrl)),
      subtitle: Text("Dostupno: ${resource.kolicina}, posudba traje ${resource.maxVrijemePosudbe.inDays} dana"),
    );
  }
}