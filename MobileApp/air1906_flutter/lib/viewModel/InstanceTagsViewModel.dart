import 'dart:typed_data';

import 'package:air1906_flutter/models/APIResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../models/ResourceInstance.dart';
import '../service/ResourceService.dart';

class InstanceTagsViewModel {
  ResourceService resourceService = ResourceService();
  BehaviorSubject<List<ResourceInstance>> _resourceList;
  BehaviorSubject<bool> _writtenTag;
  String idToWrite;

  InstanceTagsViewModel() {
    _resourceList = BehaviorSubject<List<ResourceInstance>>();
    _writtenTag = BehaviorSubject<bool>();
    _resourceList.add([]);
    loadInstancesWithoutTags();
  }

  Observable<List<ResourceInstance>> get instancesWithoutTags =>
      _resourceList.stream;
  Observable<bool> get isWrittenTag => _writtenTag;

  void loadInstancesWithoutTags() async {
    final response = await resourceService.getInstancesWithoutTags();
    _resourceList.add(response.data);
  }

  Future<void> stopNFCSession() async {
    // Stop session and unregister callback.
    await NfcManager.instance.stopSession();
  }

  Future<void> tryWritingTag(String message) async {
    idToWrite = message;
    bool res;
    NfcManager.instance.startTagSession(
      alertMessageIOS: '...',
      pollingOptions: {
        TagPollingOption.iso14443,
        TagPollingOption.iso15693,
        TagPollingOption.iso18092,
      },
      onDiscovered: (NfcTag tag) async {
        Ndef ndef = Ndef.fromTag(tag);
        if (ndef == null) {
          return null;
        }
        // NdefRecord data = ndef.cachedMessage.records.first;
        // String resourceIdFromNFC = String.fromCharCodes(data.payload);
        //print("dohvacno $resourceIdFromNFC");
        // print(resourceIdFromNFC);
        NdefMessage messageToWrite = NdefMessage(
          [
            NdefRecord.createMime(
              'text/plain',
              Uint8List.fromList(message.codeUnits),
            ),
          ],
        );
        try {
          var result = await ndef.write(messageToWrite);
          if(result){
            final response = await resourceService.updateInstanceNFCStatus(message);
            res = response.data;
            print(response.data);
            _writtenTag.add(true);
          }
        } catch (e) {
          return null;
        }
      },
    );
    // int i = 0;
    // while(res == null){
    //   await Future.delayed(Duration(milliseconds: 500));
    //   i++;
    //   if(i > 5)
    //     break;
    // }
    // stopNFCSession();
    
  }
}
