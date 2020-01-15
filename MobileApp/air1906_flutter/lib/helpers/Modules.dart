import '../nfc/NFCLoader.dart';
import '../qrCode/QRLoader.dart';
import 'package:flutter/material.dart';
import '../interface/IResourceLoader.dart';


abstract class Modules {
  static List<IResourceLoader> modules = [
    NFCLoader(),
    //QRLoader(),
  ];
}
