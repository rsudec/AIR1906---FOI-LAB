import 'package:flutter/material.dart';
enum ResourceLoaderType {
  borrowResource,
  returnResource
}
abstract class IResourceLoader {
  BuildContext context;
  String title;
  Icon icon;
  ResourceLoaderType type;
  Future<String> loadResource();
  bool availableIOS;
  //void showLoader();

}