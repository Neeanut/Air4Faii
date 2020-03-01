import 'dart:ffi';

import 'package:air4faii/utility/my_style.dart';
import 'package:air4faii/utility/normal_dialog.dart';
import 'package:air4faii/widget/my_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field

// ตั้งค่าตัวแปร
  String name, email, password;

  // Method
  Widget nameForm() {
    Color color = Colors.brown[400];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (String string) {
              name = string.trim();
            },
            decoration: InputDecoration(
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              helperStyle: TextStyle(color: color),
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.person,
                size: 24.0, //size icon
                color: color, //color icon
              ),
              helperText: 'Type Your Name in the Bank',
              labelText: 'Dispaly Name : ',
            ),
          ),
        ),
      ],
    );
  }

  Widget emailForm() {
    Color color = Colors.brown[400];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (String string) {
              email = string.trim();
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              helperStyle: TextStyle(color: color),
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.email,
                size: 24.0, //size icon
                color: color, //color icon
              ),
              helperText: 'Type Your Email in the Bank',
              labelText: 'Email : ',
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordForm() {
    Color color = Colors.brown[400];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 250.0,
          child: TextField(
            onChanged: (String string) {
              password = string.trim();
            },
            decoration: InputDecoration(
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: color)),
              helperStyle: TextStyle(color: color),
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.lock_open,
                size: 24.0, //size icon
                color: color, //color icon
              ),
              helperText: 'Type Your Password in the Bank',
              labelText: 'Password : ',
            ),
          ),
        ),
      ],
    );
  }

  Widget registerButton() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      child: OutlineButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        borderSide: BorderSide(color: MyStyle().darkColor),
        child: Text(
          'Register',
          style: TextStyle(color: MyStyle().darkColor),
        ),
        onPressed: () {
          print('name = $name, email = $email, password =$password');

          if (name == null ||
              name.isEmpty ||
              email == null ||
              email.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'Have Space', 'กรุณาใส่ข้อมูลให้ครบ');
          } else {
            registerThread();
          }
        },
      ),
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((response) {
      print('Register Success');
      setupDisplayName();
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      normalDialog(context, title, message);
    });
  }

  Future<void> setupDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute route =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return MyService();
    });
    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) {
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: MyStyle().darkColor,
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView เพิ่ม scroll ให้หน้าจอ ที่เล็ก หรือสั้น
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              nameForm(),
              emailForm(),
              passwordForm(),
              registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
