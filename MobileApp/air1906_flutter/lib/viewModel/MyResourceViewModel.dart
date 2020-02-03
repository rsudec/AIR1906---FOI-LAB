import 'package:air1906_flutter/helpers/Auth.dart';

import '../models/ResourceInstance.dart';

import '../models/User.dart';

import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/ResourceService.dart';

class MyResourceViewModel {
  BehaviorSubject<bool> _enabledButtonSubmit;
  BehaviorSubject<String> _expiredDate;

  ResourceService resourceService = ResourceService();
  BehaviorSubject<List<ResourceInstance>> _resourceList;

  MyResourceViewModel() {
    _resourceList = BehaviorSubject<List<ResourceInstance>>();
    _enabledButtonSubmit = BehaviorSubject<bool>();
    _expiredDate = BehaviorSubject<String>();

    _enabledButtonSubmit.add(false);

    getResourcesByUser(Auth.currentUser);
  }

  Observable<List<ResourceInstance>> get observableResourceList =>
      _resourceList.stream;
  Observable<bool> get enabledButtonSubmit => _enabledButtonSubmit;
  Observable<String> get expiredDate => _expiredDate;

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

  void insertCommentByUser(
      User user, String comment, ResourceInstance instance) {
    resourceService.insertCommentByUser(
      user,
      comment.replaceAll("\n", " "),
      instance,
    );
  }

  void onChangeCommentText(String text) {
    if (text.length >= 10) {
      _enabledButtonSubmit.add(true);
    } else {
      _enabledButtonSubmit.add(false);
      _enabledButtonSubmit.addError('Napišite 10 znakova');
    }
  }

  void makeExpiredDate(ResourceInstance instance) {
    DateTime _timeNow = DateTime.now();
    DateTime _timeBorrow = instance.datumPosudbe;
    Duration _hoursToExpire = instance.resource.maxVrijemePosudbe;
    String type = "";

    int difference =
        _timeNow.difference(_timeBorrow).inHours + _hoursToExpire.inHours;

    print(difference);
    if (difference > 24) {
      difference = Duration(hours: difference).inDays;
      type = "Posudba istjeće za $difference dana";
    } else if (difference < 0) {
      type = "Kasnite, molim Vas vratite resurs!";
    } else {
      type = "Posudba istjeće za $difference sati";
    }

    _expiredDate.add("$type");
  }

  void dispose() {
    _resourceList.close();
    _enabledButtonSubmit.close();
    _expiredDate.close();
  }
}
