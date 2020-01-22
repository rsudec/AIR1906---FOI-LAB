import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import '../service/ResourceService.dart';

//enum NFCType { borrowResource, returnResource }

// class NFC extends StatefulWidget {
//   //final NFCType type;
//   // final resourceId;
//   NFC(this.type);
//   @override
//   _NFCState createState() => _NFCState();
// }

// class _NFCState extends State<NFC> {
//   var success = false;
//   var result = "";
//   @override
//   void initState() {
//     super.initState();
//     listenNFC();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     NfcManager.instance.stopSession(
//       alertMessageIOS: '...',
//       errorMessageIOS: '...',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var type = widget.type;
    
//   }

//   void listenNFC() {
//     NfcManager.instance.startTagSession(
//       alertMessageIOS: '...',
//       pollingOptions: {
//         TagPollingOption.iso14443,
//         TagPollingOption.iso15693,
//         TagPollingOption.iso18092
//       },
//       onDiscovered: (NfcTag tag) async {
//         Ndef ndef = Ndef.fromTag(tag);
//         if (ndef == null) {
//           print("tag is not ndef");
//           return;
//         }
//         NdefRecord data = ndef.cachedMessage.records.first;
//         String resourceIdFromNFC = String.fromCharCodes(data.payload);

//         ResourceService rs = ResourceService();
//         if (widget.type == NFCType.borrowResource) {
//           var response = await rs.borrowResource(resourceIdFromNFC).then((val) {
//             setState(() {
//               print("res data ${val.data}");
//               if (val.data) {
//                 success = true;
//                 result = "Uspješno ste posudili $resourceIdFromNFC";
//               } else {
//                 success = false;
//               }
//             });
//           });
//         }
//         else if(widget.type == NFCType.returnResource){
//           var response = await rs.returnResource(resourceIdFromNFC).then((val) {
//             setState(() {
//               print("res data ${val.data}");
//               if (val.data) {
//                 success = true;
//                 result = "Uspješno ste vratili $resourceIdFromNFC";
//               } else {
//                 success = false;
//               }
//             });
//           });
//         }
//       },
//     );
//   }
// }
