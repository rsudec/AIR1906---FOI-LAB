import 'package:air1906_flutter/models/Resource.dart';
import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/CategoryService.dart';
import '../models/Category.dart';

class CategoriesViewModel {
  CategoryService categoryService = CategoryService();
  ResourceService resourceService = ResourceService();

  BehaviorSubject<List<Category>> _categoryList;
  BehaviorSubject<String> _categoryName;

  CategoriesViewModel() {
    _categoryList = BehaviorSubject<List<Category>>();
    _categoryName = BehaviorSubject<String>();
    _categoryName.add('Kategorija');
    getCategories();
  }

  Observable<List<Category>> get observableCategoryList => _categoryList.stream;
  Observable<String> get observableCategoryName => _categoryName.stream;
  Observable<Map<String, dynamic>> get observableCategoryMap =>
      Observable.combineLatest2(_categoryList, _categoryName,
          (value1, value2) => {'categoryList': value1, 'categoryName': value2});

  void getCategories() async {
    final response = await categoryService.getCategoryList();
    if (response.data.length > 0) {
      _categoryList.add(response.data);
    } else {
      _categoryList.addError(false);
    }
  }

  void onChangedDropDownMenu(String valueNaziv) async {
    _categoryName.add(valueNaziv);
  }

  void dispose() {
    _categoryList.close();
  }
}
