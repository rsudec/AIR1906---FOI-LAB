import 'package:rxdart/rxdart.dart';

import '../service/CategoryService.dart';
import '../models/Category.dart';

class CategoriesViewModel {
  CategoryService  categoryService = CategoryService(); 

  BehaviorSubject<List<Category>> _categoryList;

  CategoriesViewModel(){
    _categoryList = BehaviorSubject<List<Category>>();
    getCategories();
  }

  Observable<List<Category>> get observableCategoryList => _categoryList.stream;


  void getCategories() async {
    final response =  await categoryService.getCategoryList();
    if (response.data.length > 0){
      _categoryList.add(response.data);
    }
    else {
      _categoryList.addError(false);
    }
    
  }
  void dispose() {
    _categoryList.close();
  }
}