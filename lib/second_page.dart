import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder<String>(
          future: getUserName(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Text('Hello ${snapshot.data}');
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<String> getUserName() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    try {
      await remoteConfig.fetch();
      await remoteConfig.activateFetched();
    }catch(e){
      print(e.toString());
    }
    var name = remoteConfig.getString('user_name');

    return Future.value(name);
  }
}
