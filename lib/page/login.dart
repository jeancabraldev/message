import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/model/user.dart';
import 'package:message/page/home.dart';

import 'package:message/page/register.dart';
import 'package:message/route/generating_route.dart';
import 'package:message/util/color.dart';

import '../widget/path.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  String _messageError = '';

  _displayMessageError(String msg) {
    setState(() {
      _messageError = msg;
    });
  }

  _validateFields() {
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    if (email.isNotEmpty && email.contains('@')) {
      if (password.isNotEmpty) {
        setState(() {
          _displayMessageError('');

          //Instanciando classe User
          User user = User();
          user.email = email;
          user.password = password;

          _loginUser(user);
        });
      } else {
        setState(() {
          _displayMessageError('Digite sua senha');
        });
      }
    } else {
      setState(() {
        _displayMessageError('Digite um e-mail válido');
      });
    }
  }

  _loginUser(User user) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .signInWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .then((firebaseUser) {
      Navigator.pushReplacementNamed(context, GeneratingRoute.ROUTE_HOME);
    }).catchError((e) {
      setState(() {
        _displayMessageError('Erro de autenticação');
      });
    });
  }

  /* Verificando se o usuário esta logado,
    caso esteja será direcionado para Home Page
   */
  Future _checkUserLogin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogin = await auth.currentUser();

    if (userLogin != null) {
      Navigator.pushReplacementNamed(context, GeneratingRoute.ROUTE_HOME);
    }
  }

  @override
  void initState() {
    _checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: ClipPathTop(),
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      linearGradientClear,
                      linearGradientDark,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.asset('asset/image/message.png'),
                    ),
                    Text(
                      'App Message',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0, bottom: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        _messageError,
                        style: TextStyle(
                            color: textMessageError,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                        hintText: 'E-mail',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: TextField(
                      controller: _controllerPassword,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                          hintText: 'Senha',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                      obscureText: true,
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    color: linearGradientClear,
                    padding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      _validateFields();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        child: Center(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Não tem uma conta? ',
                                  style: styleTextSpan),
                              TextSpan(
                                  text: 'Cadastre-se',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ))
                            ]),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
