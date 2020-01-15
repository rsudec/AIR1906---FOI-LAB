import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Category.dart';
import '../models/Resource.dart';
import '../models/APIResponse.dart';
import '../models/ResourceType.dart';
import '../helpers/Auth.dart';

class ResourceService {
  Future<APIResponse<List<Resource>>> getResourceListByCategory(
      Category category) async {
    List<Resource> listResource = [];
    var url = "https://air-api.azurewebsites.net/TraziPoVrsti/${category.id}";
    var response = await http.get(url);
    var resourceApi = jsonDecode(response.body);
    for (var item in resourceApi) {
      listResource.add(Resource(
        item["id_resurs"],
        item["nazivr"],
        int.parse(item["kolicina"]),
        item["slika"],
        Duration(days: int.parse(item["max_posudba"])),
        ResourceType(item["fk_tip_resursa"]),
      ));
    }
    return APIResponse<List<Resource>>(listResource);
  }

  Future<APIResponse<bool>> borrowResource(String resourceId) async {
    var url = "https://air-api.azurewebsites.net/Posudi";
    print(Auth.currentUser.id);
    print(resourceId);
    try {
      var response = await http.post(
        url,
        body: {
          "idkor": Auth.currentUser.id,
          "idins": resourceId,
        },
      );
      if (response.statusCode == 200) {
        return APIResponse<bool>(true);
      }
      return APIResponse<bool>(false);
    } catch (e) {
      return APIResponse<bool>(false);
    }
  }

  Future<APIResponse<bool>> returnResource(String resourceId) async {
    var url = "https://air-api.azurewebsites.net/Vrati";
    print(Auth.currentUser.id);
    print(resourceId);
    try {
      var response = await http
          .post(url, body: {"idkor": Auth.currentUser.id, "idins": resourceId});
      print(response.statusCode);
      if (response.statusCode == 200) {
        return APIResponse<bool>(true);
      }
      return APIResponse<bool>(false);
    } catch (e) {
      return APIResponse<bool>(false);
    }
  }
}
