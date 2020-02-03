import 'package:air1906_flutter/helpers/Auth.dart';
import 'package:air1906_flutter/models/APIResponse.dart';
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

  ResourceService resourceService = ResourceService();
  CategoryService categoryService = CategoryService();

  BehaviorSubject<bool> _enabledButtonSlobodno;
  BehaviorSubject<List<Resource>> _resourceList;

  List<Resource> listResource;
  String itemCategory = 'Sve';
  String textSearch;
  String category;
  bool buttonAvaliable = false;

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
    listResource = response.data;
    _resourceList.add(listResource);
  }

  void getAllResourceByCategory(String valueNaziv) async {
    // if (valueNaziv == 'Sve') {
    //   itemCategory = null;
    //   getAllResource();
    //   return;
    // }
    // final response = await categoryService.getCategoryList();
    // response.data.forEach((value) {
    //   if (valueNaziv == value.naziv) {
    //     itemCategory = value;
    //     return;
    //   }
    // });
    itemCategory = valueNaziv;
    if (itemCategory != 'Sve') {
      listResource =
          listResource.where((item) => item.kategorija == valueNaziv).toList();
    }
  }

  void toggleAvailableButton() async {
    if (_enabledButtonSlobodno.value == true) {
      _enabledButtonSlobodno.add(false);
      buttonAvaliable = false;
    } else {
      _enabledButtonSlobodno.add(true);
      buttonAvaliable = true;
    }
  }

  void filterButton() async {
    if (buttonAvaliable) {
      _resourceList.add(listResource =
          listResource.where((item) => item.kolicina > item.zauzeto).toList());
    }
  }

  void onSearchTextChange(String searchText) async {
    if (searchText.isNotEmpty) {
      textSearch = searchText;
      listResource = listResource
          .where((item) => item.naziv.contains(searchText))
          .toList();
    }
  }

  void refreshScreen() async {
    //   Category itemCategory;
    // String textSearch;
    // bool buttonAvaliable;
    if (itemCategory != 'Sve') {
      getAllResourceByCategory(itemCategory);
      print('category');
      print(itemCategory);
    }
    if (textSearch != null) {
      onSearchTextChange(textSearch);
      print('textsearch');
    }
    if (buttonAvaliable) {
      print('button');
      print(buttonAvaliable);
      filterButton();
    }

    if (listResource.length == 0) {
      _resourceList.addError('Nema resursa');
    } else {
      _resourceList.add(listResource);
    }

    final response = await resourceService.getAllResourceFromDatabase();
    listResource = response.data;
  }

  void dispose() {
    _resourceList.close();
  }
}
