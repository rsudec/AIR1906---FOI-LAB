import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Category.dart';

import '../models/APIResponse.dart';

class CategoryService {
  Future<APIResponse<List<Category>>> getCategoryList() async {
    List<Category> listCategory = [];
    String url = "https://air-api.azurewebsites.net/VrsteResursa";
    var response = await http.get(url);
    var categoriesApi = jsonDecode(response.body);
    for (var item in categoriesApi) {
      //print(item);
      listCategory
          .add(Category(item["id_tip_resursa"], item["nazivtr"], item["opis"]));
    }
    return APIResponse<List<Category>>(listCategory);
  }
}
