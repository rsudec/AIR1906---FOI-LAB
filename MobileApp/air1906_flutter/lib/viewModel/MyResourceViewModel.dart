import '../models/Shop.dart';
import '../models/UserRole.dart';

import '../models/User.dart';

import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/ResourceService.dart';
import '../models/Resource.dart';

class MyResourceViewModel {
  String _validComment;

  BehaviorSubject<bool> _enabledButtonSubmit;
  BehaviorSubject<String> _errorInvalidComment;

  ResourceService resourceService = ResourceService();
  BehaviorSubject<List<Resource>> _resourceList;

  MyResourceViewModel() {
    _resourceList = BehaviorSubject<List<Resource>>();
    _enabledButtonSubmit = BehaviorSubject<bool>();

    _enabledButtonSubmit.add(false);

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
  Observable<bool> get enabledButtonSubmit => _enabledButtonSubmit;

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

  void insertCommentByUser(User user, String comment) {
    var reponse = resourceService.insertCommentByUser(user, comment);
  }

  void onChangeCommentText(String text) {
    if (text.length >= 10) {
      _enabledButtonSubmit.add(true);
    } else {
      _enabledButtonSubmit.add(false);
      _enabledButtonSubmit.addError('Napišite 10 znakova');
    }
  }

  void dispose() {
    _resourceList.close();
  }
}
