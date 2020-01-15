import 'package:flutter/material.dart';

abstract class IResourceLoader {
  BuildContext context;
  String title;
  Icon icon;
  Future<String> loadResource();
  Future<String> loadResource1();
  //void showLoader();

}