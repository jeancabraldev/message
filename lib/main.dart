import 'package:flutter/material.dart';
import 'package:message/route/generating_route.dart';
import 'package:message/util/color.dart';
import './page/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackground,
        primaryColor: linearGradientDark,
        accentColor: linearGradientClear,
        fontFamily: 'Montserrat',
      ),
      title: 'Message',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: GeneratingRoute.generatingRoute,
    );
  }
}
