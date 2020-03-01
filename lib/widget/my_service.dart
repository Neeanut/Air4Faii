import 'package:air4faii/utility/my_style.dart';
import 'package:air4faii/widget/authen.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field

  String nameLogin = '';
  String url =
      'http://air4thai.pcd.go.th/services/getNewAQI_JSON.php?stationID=05t';
  
  String resultName = '';
  // Method

  @override
  void initState() {
    super.initState();
    findNameLogin();
    readAPI();
  }


Future<void> readAPI()async{

try {
  
Response response = await Dio().get(url);
print('response = $response');


} catch (e) {
}


}


  Future<void> findNameLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await auth.currentUser();
    setState(() {
      nameLogin = firebaseUser.displayName;
      print('name = $nameLogin');
      if (nameLogin == null) {
        nameLogin = 'Unknow';
      }
    });
  }

  Widget showNameLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$nameLogin Login'),
      ],
    );
  }

  Widget singOutButton() {
    return IconButton(
      tooltip: 'SignOut',
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        signOutProcess();
      },
    );
  }

  Future<void> signOutProcess() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((response) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (context) => Authen());
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().darkColor,
        actions: <Widget>[showNameLogin(), singOutButton()],
        title: Text('Air4Faii'),
      ),
    );
  }
}
