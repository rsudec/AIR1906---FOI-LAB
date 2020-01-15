import '../helpers/Modules.dart';
import '../interface/IResourceLoader.dart';

import '../service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

class BorrowViewModel {
  ResourceService resourceService = ResourceService();

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

  void borrowResource(String resId) async {
    if (resId == null) {
      _resourceBorrowMessage.addError("Greška");
      return;
    } else {
      var response = await resourceService.borrowResource(resId).then((val) {
        print("res data ${val.data}");
        if (val.data) {
          _resourceBorrowMessage.add("Success [$resId]");
        } else {
          _resourceBorrowMessage.addError("Greška");
        }
      });
    }
  }
  void returnResource(String resId) async {
    if (resId == null) {
      _resourceBorrowMessage.addError("Greška");
      return;
    } else {
      var response = await resourceService.returnResource(resId).then((val) {
        print("res data ${val.data}");
        if (val.data) {
          _resourceBorrowMessage.add("Success [$resId]");
        } else {
          _resourceBorrowMessage.addError("Greška");
        }
      });
    }
  }

  void dispose() {
    _resourceLoaderList.close();
  }
}
