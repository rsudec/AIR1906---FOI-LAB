import 'package:air1906_flutter/models/MyContainer.dart';
import 'package:air1906_flutter/models/Resource.dart';
import 'package:air1906_flutter/service/ResourceService.dart';
import 'package:rxdart/rxdart.dart';

import '../service/CategoryService.dart';
import '../models/Category.dart';

class DetailScreenViewModel {
  ResourceService resourceService = ResourceService();
  Resource resource;
  BehaviorSubject<List<MyContainer>> _containerList;

  DetailScreenViewModel() {
    _containerList = BehaviorSubject<List<MyContainer>>();
    
  }

  Observable<List<MyContainer>> get observableContainerList => _containerList.stream;

  void getResourceContainers(String id) async {
    var containers = await resourceService.getResourceLocations(id);
    _containerList.add(containers.data);
  }
  void dispose() {
    _containerList.close();
  }
}
