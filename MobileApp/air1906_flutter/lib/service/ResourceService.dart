import 'dart:async';
import 'dart:convert';

import '../models/Category.dart';
import '../models/ResourceType.dart';

import '../models/Resource.dart';
import '../models/APIResponse.dart';
import 'package:http/http.dart' as http;
import '../models/User.dart';

class ResourceService {
  final _resources = [
    {
      "id": "asdbmrg",
      "naziv": "Laptop Acer",
      "kolicina": "6",
      "imgUrl":
          "https://images.idgesg.net/images/article/2019/10/aceraspire1-100815704-large.jpg",
      "maxVrijemePosudbe": "2",
      "tipResursa": "1",
    },
    {
      "id": "gbysdb",
      "naziv": "Laptop Apple",
      "kolicina": "2",
      "imgUrl":
          "https://www.ronis.hr/slike/velike/laptop-apple-macbook-pro-15-touch-bar-8--mv932cr-a_1.jpg",
      "maxVrijemePosudbe": "3",
      "tipResursa": "1",
    },
    {
      "id": "sfghfgnd",
      "naziv": "Mobitel Android",
      "kolicina": "3",
      "imgUrl":
          "https://www.lg.com/us/images/cell-phones/md05866667/gallery/medium01.jpg",
      "maxVrijemePosudbe": "5",
      "tipResursa": "1",
    },
    {
      "id": "sznfghg",
      "naziv": "Arduino",
      "kolicina": "2",
      "imgUrl":
          "https://www.trossenrobotics.com/shared/images/PImages/C-400-DEV-A000046-a.jpg",
      "maxVrijemePosudbe": "7",
      "tipResursa": "1",
    },
  ];

  Future<APIResponse<List<Resource>>> getResourceList() async {
    List<Resource> listResource = [];
    await Future.delayed(Duration(seconds: 3));
    for (var item in _resources) {
      String id = item["id"];
      String naziv = item["naziv"];
      int kolicina = int.parse(item["kolicina"]);
      String imgUrl = item["imgUrl"];
      Duration maxVrijemePosudbe =
          Duration(days: int.parse(item["maxVrijemePosudbe"]));
      listResource.add(Resource(
          id, naziv, kolicina, imgUrl, maxVrijemePosudbe, ResourceType('id1')));
    }
    return APIResponse<List<Resource>>(listResource);
  }

  Future<APIResponse<List<Resource>>> getResourceListByCategory(
      Category category) async {
    List<Resource> listResource = [];
    //print("pozivam resurse");
    var url = "https://air-api.azurewebsites.net/TraziPoVrsti/${category.id}";
    var response = await http.get(url);
    var resourceApi = jsonDecode(response.body);
    for (var item in resourceApi) {
      listResource.add(Resource(
        item["id_resurs"],
        item["naziv"],
        int.parse(item["kolicina"]),
        item["slika"],
        Duration(days: int.parse(item["max_posudba"])),
        ResourceType(item["fk_tip_resursa"]),
      ));
    }
    return APIResponse<List<Resource>>(listResource);
  }

  Future<APIResponse<List<Resource>>> getResourceListByUser(User user) async {
    List<Resource> listResource = [];
    //print("pozivam resurse");
    // var url = "https://air-api.azurewebsites.net/TraziPoVrsti/${user.id}";
    // var response = await http.get(url);
    // var resourceApi = jsonDecode(response.body);
    // for (var item in resourceApi) {
    //   listResource.add(Resource(
    //     item["id_resurs"],
    //     item["naziv"],
    //     int.parse(item["kolicina"]),
    //     item["slika"],
    //     Duration(days: int.parse(item["max_posudba"])),
    //     ResourceType(item["fk_tip_resursa"]),
    //   ));
    // }
    listResource.add(
        Resource('a', 'aa', 1, 'aaa', Duration(hours: 1), ResourceType('id1')));
    listResource.add(
        Resource('b', 'bb', 2, 'bbb', Duration(hours: 2), ResourceType('id2')));
    listResource.add(
        Resource('c', 'cc', 3, 'ccc', Duration(hours: 3), ResourceType('id2')));
    return APIResponse<List<Resource>>(listResource);
  }
}
