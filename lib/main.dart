import 'package:flutter/material.dart';
import './page/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.orange,
        textTheme: TextTheme(
          body1: TextStyle(fontFamily: 'Montserrat'),
        )
      ),
      title: 'Message',
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}


