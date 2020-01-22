import 'package:air1906_flutter/helpers/Auth.dart';
import 'package:air1906_flutter/models/Category.dart';
import 'package:air1906_flutter/service/CategoryService.dart';

import '../models/ResourceInstance.dart';

import '../models/User.dart';

import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/ResourceService.dart';
import '../models/Resource.dart';

class SearchResourceViewModel {
  String _validComment;

  BehaviorSubject<bool> _enabledButtonSlobodno;

  ResourceService resourceService = ResourceService();
  CategoryService categoryService = CategoryService();

  BehaviorSubject<List<Resource>> _resourceList;

  SearchResourceViewModel() {
    _resourceList = BehaviorSubject<List<Resource>>();
    _enabledButtonSlobodno = BehaviorSubject<bool>();
    getAllResource();
    _enabledButtonSlobodno.add(false);
  }

  Observable<List<Resource>> get observableResourceList => _resourceList.stream;
  Observable<bool> get enabledButtonSlobdno => _enabledButtonSlobodno;

  void getAllResource() async {
    final response = await resourceService.getAllResourceFromDatabase();
    _resourceList.add(response.data);
    print(response.data);
  }

  void getAllResourceByCategory(String valueNaziv) async {
    Category itemCategory;
    if (valueNaziv == 'Sve') {
      getAllResource();
      return;
    }
    final response = await categoryService.getCategoryList();
    response.data.forEach((value) {
      if (valueNaziv == value.naziv) {
        itemCategory = value;
        return;
      }
    });

    final reponse2 =
        await resourceService.getResourceListByCategory(itemCategory);
    _resourceList.add(reponse2.data);
  }

  void dispose() {
    _resourceList.close();
  }
}
