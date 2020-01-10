import 'dart:async';
import 'dart:convert';

import '../models/Category.dart';
import '../models/ResourceType.dart';

import '../models/Resource.dart';
import '../models/APIResponse.dart';
import 'package:http/http.dart' as http;
import '../models/User.dart';

class ResourceService {
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

  Future<APIResponse<bool>> insertCommentByUser(
      User user, String comment) async {
    // var response =
    //    await http.post("www.pornhub.com", body: {"Comment": comment, "UserId": user.id});
    print(comment);
    // if (response.body.isNotEmpty) return APIResponse<bool>(true);
    return APIResponse<bool>(true);
  }
}
