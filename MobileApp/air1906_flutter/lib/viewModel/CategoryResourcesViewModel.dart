import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/ResourceService.dart';
import '../models/Resource.dart';
import '../models/Category.dart';

class CategoryResourceViewModel {
  ResourceService resourceService = ResourceService();
  Category currentCategory;
  BehaviorSubject<List<Resource>> _resourceList;

  CategoryResourceViewModel(Category currentCategory) {
    _resourceList = BehaviorSubject<List<Resource>>();
    this.currentCategory = currentCategory;
    getResourcesByCategory(this.currentCategory);
  }

  Observable<List<Resource>> get observableResourceList => _resourceList.stream;

  void getResourcesByCategory(Category category) async {
    if (category != null) {
      final response =
          await resourceService.getResourceListByCategory(category);
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
