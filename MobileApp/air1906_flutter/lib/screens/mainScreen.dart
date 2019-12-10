import 'package:air1906_flutter/models/APIResponse.dart';
import 'package:air1906_flutter/models/Resource.dart';
import 'package:air1906_flutter/widgets/ResourceItem.dart';
import 'package:flutter/material.dart';

import '../service/ResourceService.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/main';  
  var service = ResourceService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dobrodošli"),),
      body: FutureBuilder(
        future: service.getResourceList(),
        builder: (ctx, dataSnaphot) {
          if(dataSnaphot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          else if( dataSnaphot.error != null){
            return Center(child: Text("Error"));
          }
          else {
            print(dataSnaphot);
            APIResponse<List<Resource>> res = dataSnaphot.data;
            print(res.data);

            return ListView.builder(
              itemCount: res.data.length,
              itemBuilder: (ctx, i) => ResourceItem(res.data[i]),
            ); 
          }
        },
      ),
    );
  }
}