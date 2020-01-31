import '../models/ResourceInstance.dart';

import '../helpers/Modules.dart';
import '../helpers/Auth.dart';
import '../interface/IResourceLoader.dart';

import '../service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

class BorrowViewModel {
  ResourceService resourceService = ResourceService();
  List<ResourceInstance> myResources;
  String wantedResourceId;
  String wantedResourceQuantity;

  BehaviorSubject<List<IResourceLoader>> _resourceLoaderList;
  BehaviorSubject<String> _resourceBorrowMessage;
  BehaviorSubject<bool> _resourceIsMultiple;
  BehaviorSubject<String> _resourceMaxQuantity;
  BehaviorSubject<bool> _enableSubmit;
  BehaviorSubject<ResourceInstance> _instance;

  BorrowViewModel() {
    _resourceLoaderList = BehaviorSubject<List<IResourceLoader>>();
    _resourceBorrowMessage = BehaviorSubject<String>();
    _resourceIsMultiple = BehaviorSubject<bool>();
    _resourceMaxQuantity = BehaviorSubject<String>();
    _enableSubmit = BehaviorSubject<bool>();
    _instance = BehaviorSubject<ResourceInstance>();

    initialLoad();
  }

  Observable<List<IResourceLoader>> get observableLoaderList =>
      _resourceLoaderList.stream;
  Observable<String> get observableBorrowMessage => _resourceBorrowMessage;
  Observable<bool> get resourceIsMultiple => _resourceIsMultiple.stream;
  Observable<String> get resourceMaxQuantity => _resourceMaxQuantity.stream;
  Observable<bool> get enabledSubmit => _enableSubmit;
  Observable<ResourceInstance> get instanceName => _instance;
  Stream get obs => CombineLatestStream.combine2(resourceIsMultiple, resourceMaxQuantity, (resourceIsMultiple, resourceMaxQuantity) => {"multiple" : resourceIsMultiple, "maxQ": resourceMaxQuantity} );
  

  void initialLoad() {
    _resourceLoaderList.add(Modules.modules);
  }

  void checkResourceQuantity() async {
    var wantedResourceResponse =
        await resourceService.getInstanceById(wantedResourceId);
    ResourceInstance wantedResource = wantedResourceResponse.data;
    if (wantedResourceQuantity == "") {
      wantedResourceQuantity = "0";
    }
    if (wantedResource.kolicina >= int.tryParse(wantedResourceQuantity) &&
        wantedResourceQuantity != "0") {
      _enableSubmit.add(true);
    } else {
      _enableSubmit.add(false);
    }
  }

  Future<void> checkResourceType(String id) async {
    
    wantedResourceId = id;
    var wantedResourceResponse = await resourceService.getInstanceById(id);
    ResourceInstance wantedResource = wantedResourceResponse.data;
    _instance.add(wantedResource);
    _resourceMaxQuantity.add(wantedResource.kolicina.toString());
    print("traženi ID tip ${wantedResource.resource.tipResursa.id}");
    if (wantedResource.kolicina > 1) {
      _enableSubmit.add(false);
      _resourceIsMultiple.add(true);
    } else {
      _enableSubmit.add(null);
      _resourceIsMultiple.add(false);
    }
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
    } catch (e) {
      return false;
    }
  }

  void borrowResource(String resId) async {
    bool alreadyBorrowed = await checkResources(resId);
    final response = await resourceService.getInstanceById(resId);
    ResourceInstance instance = response.data;
    if (resId == null) {
      _resourceBorrowMessage.addError("Greška");
      messageTimeout();
      return;
    } else if (alreadyBorrowed) {
      _resourceBorrowMessage.addError("Već ste posudili resurs");
      messageTimeout();
      return;
    } else if (instance.kolicina == 0) {
      _resourceBorrowMessage.addError("Nema slobodnih instanci");
      messageTimeout();
      return;
    } else {
      if (wantedResourceQuantity != null) {
        await resourceService
            .borrowResource(resId, wantedResourceQuantity)
            .then(
          (val) {
            print("res data ${val.data}");
            if (val.data) {
              _resourceBorrowMessage.add(
                  "Posudili ste $wantedResourceQuantity komada - ${instance.resource.naziv}");
            } else {
              _resourceBorrowMessage.addError("Posudba odbijena");
            }
          },
        );
        wantedResourceQuantity = null;
      } else {
        await resourceService.borrowResource(resId).then(
          (val) {
            print("res data ${val.data}");
            if (val.data) {
              _resourceBorrowMessage
                  .add("Posudili ste [${instance.resource.naziv}]");
            } else {
              _resourceBorrowMessage.addError("Posudba odbijena");
            }
          },
        );
      }
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

  void messageTimeout() {
    Future.delayed(Duration(seconds: 2)).then((x) {
      _resourceBorrowMessage.add("");
      _resourceBorrowMessage.addError("");
    });
  }

  void dispose() {
    _resourceBorrowMessage.close();
    _resourceLoaderList.close();
    _resourceIsMultiple.close();
    _resourceMaxQuantity.close();
    _enableSubmit.close();
    _instance.close();
  }
}
