import 'dart:ffi';

import 'package:air4faii/utility/my_style.dart';
import 'package:air4faii/widget/my_service.dart';
import 'package:air4faii/widget/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// Field

// Method

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (BuildContext buildContext) {
        return MyService();
      });
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    }
  }

  Widget loginButton() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        child: Text(
          'Log In',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget newRegisterButton() {
    return FlatButton(
      child: Text(
        'New Register',
        style: TextStyle(
          color: MyStyle().darkColor,
          fontStyle: FontStyle.italic,
        ),
      ),
      onPressed: () {
        print('You Click Register');

        MaterialPageRoute route =
            MaterialPageRoute(builder: (BuildContext context) {
          return Register();
        });
        Navigator.of(context).push(route);
      },
    );
  }

  Widget userForm() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: 250.0,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          //enabledBorder: UnderlineInputBorder(
          // borderSide: BorderSide(color: MyStyle().darkColor)),
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'Username :',
        ),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: MyStyle().darkColor)),
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'Password :',
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 170.0,
      height: 170.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Air4Faii',
      style: GoogleFonts.comfortaa(
        textStyle: TextStyle(
          color: MyStyle().darkColor,
          // fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white54, MyStyle().primaryColor],
            radius: 1.7,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              showLogo(),
              showAppName(),
              userForm(),
              passwordForm(),
              loginButton(),
              newRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
