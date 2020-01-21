import 'package:air1906_flutter/helpers/Auth.dart';

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
  BehaviorSubject<List<Resource>> _resourceList;

  SearchResourceViewModel() {
    _resourceList = BehaviorSubject<List<Resource>>();
    _enabledButtonSlobodno = BehaviorSubject<bool>();

    _enabledButtonSlobodno.add(false);
  }

  Observable<List<Resource>> get observableResourceList => _resourceList.stream;
  Observable<bool> get enabledButtonSlobdno => _enabledButtonSlobodno;

  void getAllResource() async {
    final response = await resourceService.getAllResourceFromDatabase();
    _resourceList.add(response.data);
  }

  void onChangeSearchText(String text) {}

  void dispose() {
    _resourceList.close();
  }
}
