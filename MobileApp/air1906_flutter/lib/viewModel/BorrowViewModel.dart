import 'package:air1906_flutter/models/ResourceInstance.dart';

import '../helpers/Modules.dart';
import '../helpers/Auth.dart';
import '../interface/IResourceLoader.dart';

import '../service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

class BorrowViewModel {
  ResourceService resourceService = ResourceService();
  List<ResourceInstance> myResources;

  BehaviorSubject<List<IResourceLoader>> _resourceLoaderList;
  BehaviorSubject<String> _resourceBorrowMessage;

  BorrowViewModel() {
    _resourceLoaderList = BehaviorSubject<List<IResourceLoader>>();
    _resourceBorrowMessage = BehaviorSubject<String>();
    initialLoad();
  }

  Observable<List<IResourceLoader>> get observableLoaderList =>
      _resourceLoaderList.stream;
  Observable<String> get observableBorrowMessage => _resourceBorrowMessage;

  void initialLoad() {
    _resourceLoaderList.add(Modules.modules);
  }

  Future<bool> checkResources(String resId) async {
    var myResources =
        await resourceService.getResourceListByUser(Auth.currentUser);
    try {
      if (myResources.data.singleWhere((item) => item.id == resId) != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {return false;}
  }

  void borrowResource(String resId) async {
    bool alreadyBorrowed = await checkResources(resId);
    if (resId == null) {
      _resourceBorrowMessage.addError("Greška");
      messageTimeout();
      return;
    } else if (alreadyBorrowed) {
      _resourceBorrowMessage.addError("Resurs je posuđen");
      messageTimeout();
      return;
    } else {
      await resourceService.borrowResource(resId).then((val) {
        print("res data ${val.data}");
        if (val.data) {
          _resourceBorrowMessage.add("Posudili ste [$resId]");
        } else {
          _resourceBorrowMessage.addError("Posudba odbijena");
        }
      });
    }
    messageTimeout();
  }

  void returnResource(String resId) async {
    bool alreadyBorrowed = await checkResources(resId);

    if (resId == null) {
      _resourceBorrowMessage.addError("Greška");
      messageTimeout();
      return;
    } else if (alreadyBorrowed == false) {
      _resourceBorrowMessage.addError("Resurs nije posuđen");
      messageTimeout();
      return;
    } else {
      await resourceService.returnResource(resId).then((val) {
        print("res data ${val.data}");
        if (val.data) {
          _resourceBorrowMessage.add("Vratili ste [$resId]");
        } else {
          _resourceBorrowMessage.addError("Vraćanje odbijeno");
        }
      });
    }
    messageTimeout();
    
  }
  void messageTimeout(){
    Future.delayed(Duration(seconds: 2)).then((x){
      _resourceBorrowMessage.add("");
      _resourceBorrowMessage.addError("");
    });
  }
  void dispose() {
    _resourceBorrowMessage.close();
    _resourceLoaderList.close();
  }
}
