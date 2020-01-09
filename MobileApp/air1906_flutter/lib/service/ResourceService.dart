import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Category.dart';
import '../models/Resource.dart';
import '../models/APIResponse.dart';
import '../models/ResourceType.dart';

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
        Duration(days: int.parse(item["max_posudba"]) ) ,
        ResourceType(item["fk_tip_resursa"]),
      ));
    }
    return APIResponse<List<Resource>>(listResource);
  }
}
