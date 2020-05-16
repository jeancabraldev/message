import 'package:flutter/material.dart';
import 'package:message/util/color.dart';
import './page/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackground,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orange,
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      title: 'Message',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}


