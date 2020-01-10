import '../models/Shop.dart';
import '../models/UserRole.dart';

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
    getResourcesByUser(User(
        id: "id_korisnik",
        ime: "ime",
        prezime: "prezime",
        telefon: "telefon",
        adresa: "adresa",
        email: "email",
        oib: "oib",
        username: "kor_ime",
        password: "lozinka",
        uloga: UserRole("fk_uloga"),
        poslovnica: Shop("fk_poslovnica")));
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
