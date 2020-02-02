import 'package:easy_dialog/easy_dialog.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../interface/IResourceLoader.dart';
import 'package:flutter/material.dart';

class NFCLoader implements IResourceLoader {
  BuildContext context;
  ResourceLoaderType type;
  String title = "NFC";
  NfcTag tag;
  String id;
  Icon icon = Icon(
    Icons.nfc,
    color: Colors.white,
  );

  @override
  Future<String> loadResource() async {
    
    String nfcResult;
    showNFCDialog();
    nfcResult = await listenNFC().then((x) {
      return x;
    });
    NfcManager.instance.stopSession();
    return nfcResult;
  }

  Future<String> listenNFC() async {
    String res;
    try {
      await NfcManager.instance.startTagSession(
        alertMessageIOS: '...',
        pollingOptions: {
          TagPollingOption.iso14443,
          TagPollingOption.iso15693,
          TagPollingOption.iso18092
        },
        onDiscovered: (NfcTag tag) async {
          Ndef ndef = Ndef.fromTag(tag);
          if (ndef == null) {
            return null;
          }
          NdefRecord data = ndef.cachedMessage.records.first;
          String resourceIdFromNFC = String.fromCharCodes(data.payload);
          //print("dohvacno $resourceIdFromNFC");
          res = resourceIdFromNFC;
          Navigator.of(context).pop();
        },
      );
    } catch (e) {}
    while (res == null) {
      await Future.delayed(Duration(milliseconds: 500));
    }
    return res;
    // return await Future.delayed(Duration(seconds: 3)).then((x) {
    // });
  }

  void showNFCDialog() {
    EasyDialog(
        height: MediaQuery.of(context).size.height / 2,
        cornerRadius: 15,
        cardColor: Colors.white,
        contentList: [
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Scan for resource",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Image(
                      color: Colors.orange,
                      colorBlendMode: BlendMode.color,
                      image: AssetImage("assets/images/NFCImage.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Hold your phone near the NFC tag"),
                ],
              ),
            )),
          ),
        ]).show(context);
  }
}
