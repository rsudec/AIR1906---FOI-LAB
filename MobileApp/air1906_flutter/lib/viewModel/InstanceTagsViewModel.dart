import 'dart:typed_data';

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

  Future<bool> writeTag(NfcTag tag) async {}

  Future<void> tryWritingTag(String message) async {
    idToWrite = message;
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
            var res = await resourceService.updateInstanceNFCStatus(message);
            print(res.data);
            _writtenTag.add(true);
          }
        } catch (e) {
          return null;
        }
      },
    );

    // // Stop session and unregister callback.
    // await NfcManager.instance.stopSession(
    //   alertMessageIOS: '...',
    //   errorMessageIOS: '...',
    // );
  }
}
