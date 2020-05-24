import 'package:flutter/material.dart';
import 'package:message/page/config.dart';
import 'package:message/page/home.dart';
import 'package:message/page/login.dart';
import 'package:message/page/message.dart';
import 'package:message/page/register.dart';


class GeneratingRoute {

  static const String ROUTE_INITIAL = '/';
  static const String ROUTE_LOGIN = '/login';
  static const String ROUTE_REGISTER = '/register';
  static const String ROUTE_HOME = '/home';
  static const String ROUTE_CONFIG = '/config';
  static const String ROUTE_MESSAGE = '/message';

  static Route<dynamic> generatingRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case ROUTE_INITIAL:
        return MaterialPageRoute(builder: (_) => Login());
      case ROUTE_LOGIN:
        return MaterialPageRoute(builder: (_) => Login());
      case ROUTE_REGISTER:
        return MaterialPageRoute(builder: (_) => Register());
      case ROUTE_HOME:
        return MaterialPageRoute(builder: (_) => Home());
      case ROUTE_CONFIG:
        return MaterialPageRoute(builder: (_) => Config());
      case ROUTE_MESSAGE:
        return MaterialPageRoute(builder: (_) => Message(args));
      default:
        _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('Tela não encontrada!'),
        ),
      );
    });
  }
}
