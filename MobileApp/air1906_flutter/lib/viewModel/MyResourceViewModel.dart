import '../models/User.dart';

import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/ResourceService.dart';
import '../models/Resource.dart';

class MyResourceViewModel {
  ResourceService resourceService = ResourceService();
  BehaviorSubject<List<Resource>> _resourceList;

  MyResourceViewModel() {
    _resourceList = BehaviorSubject<List<Resource>>();
    getResourcesByUser(User('a', 'bbb', 'bbb'));
  }

  Observable<List<Resource>> get observableResourceList => _resourceList.stream;

  void getResourcesByUser(User user) async {
    if (user != null) {
      final response = await resourceService.getResourceListByUser(user);
      if (response.data.length > 0) {
        _resourceList.add(response.data);
      } else {
        _resourceList.addError(false);
      }
    }
  }

  void dispose() {
    _resourceList.close();
  }
}
