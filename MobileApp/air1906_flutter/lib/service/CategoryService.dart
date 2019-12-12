import 'dart:async';


import '../models/Category.dart';

import '../models/APIResponse.dart';

class CategoryService {

  final _categories = [
    {
      "id" : "cat1",
      "naziv" : "Laptop",
      "opis" : "Naša ponuda laptopa"
    },
    {
      "id" : "cat2",
      "naziv" : "Mobitel",
      "opis" : "Naša ponuda mobitela"
    },
    {
      "id" : "cat3",
      "naziv" : "Uređaj",
      "opis" : "Naša ponuda uređaja"
    },
    {
      "id" : "cat4",
      "naziv" : "Materijal",
      "opis" : "Naša ponuda materijala"
    },
    {
      "id" : "cat5",
      "naziv" : "Alat",
      "opis" : "Naša ponuda alata"
    },
  ];

  Future<APIResponse<List<Category>>> getCategoryList() async {
    List<Category> listCategory = [];
    //
    await Future.delayed(Duration(seconds: 3));
    //
    for(var item in _categories){
      
      String id = item["id"];
      String naziv = item["naziv"];
      String opis = item["opis"];
      listCategory.add(Category(id, naziv, opis,));
    }
    return APIResponse<List<Category>>(listCategory);
  }
}