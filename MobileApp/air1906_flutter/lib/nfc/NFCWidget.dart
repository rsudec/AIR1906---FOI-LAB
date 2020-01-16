import 'package:flutter/material.dart';

class NFCWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      child: Center(
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                // type == NFCType.borrowResource ?
                "Posudi resurs",
                // : "Vrati resurs",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text("Prislonite uređaj na NFC oznaku"),
              Container(
                child: Image(
                  image: AssetImage("assets/images/NFCImage.png"),
                ),
              ),
              // Text(result),
              // success
              //     ? Text(
              //         result,
              //         style: TextStyle(
              //             color: Colors.green, fontWeight: FontWeight.bold),
              //       )
              //     : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
