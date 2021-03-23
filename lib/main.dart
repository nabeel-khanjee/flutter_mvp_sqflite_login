import 'package:flutter/material.dart';
import 'package:flutter_sqflite_mvp_architechture/pager/login/login_page.dart';
import 'package:flutter_sqflite_mvp_architechture/pager/home_page.dart';

void main() => runApp(new MyApp());

final route = {
  '/login' : (BuildContext context) => LoginPage(),
  '/home' :  (BuildContext context) => HomePage(),
  '/' : (BuildContext context) => LoginPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
          primarySwatch: Colors.teal, primaryColor: Colors.redAccent),
      home: new HomePage(),
      title: "Sqflite App",
      routes: route,
    );
  }
}

