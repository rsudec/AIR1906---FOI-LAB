
import 'dart:async';

import '../models/Resource.dart';
import '../models/APIResponse.dart';

class ResourceService {

  final _resources = [
    {
      "id" : "asdbmrg",
      "naziv" : "Laptop Acer",
      "kolicina" : "6",
      "imgUrl" : "https://images.idgesg.net/images/article/2019/10/aceraspire1-100815704-large.jpg",
      "maxVrijemePosudbe" : "2",
      "tipResursa" : "1",
    },
    {
      "id" : "gbysdb",
      "naziv" : "Laptop Apple",
      "kolicina" : "2",
      "imgUrl" : "https://www.ronis.hr/slike/velike/laptop-apple-macbook-pro-15-touch-bar-8--mv932cr-a_1.jpg",
      "maxVrijemePosudbe" : "3",
      "tipResursa" : "1",
    },
    {
      "id" : "sfghfgnd",
      "naziv" : "Mobitel Android",
      "kolicina" : "3",
      "imgUrl" : "https://www.lg.com/us/images/cell-phones/md05866667/gallery/medium01.jpg",
      "maxVrijemePosudbe" : "5",
      "tipResursa" : "1",
    },
    {
      "id" : "sznfghg",
      "naziv" : "Arduino",
      "kolicina" : "2",
      "imgUrl" : "https://www.trossenrobotics.com/shared/images/PImages/C-400-DEV-A000046-a.jpg",
      "maxVrijemePosudbe" : "7",
      "tipResursa" : "1",
    },
  ];

  Future<APIResponse<List<Resource>>> getResourceList() async {
    List<Resource> listResource = [];
    await Future.delayed(Duration(seconds: 3));
    for(var item in _resources){
      
      String id = item["id"];
      String naziv = item["naziv"];
      int kolicina = int.parse(item["kolicina"]);
      String imgUrl = item["imgUrl"];
      Duration maxVrijemePosudbe = Duration(days: int.parse(item["maxVrijemePosudbe"]));
      listResource.add(Resource(id, naziv, kolicina, imgUrl, maxVrijemePosudbe));
    }
    return APIResponse<List<Resource>>(listResource);
  }

}