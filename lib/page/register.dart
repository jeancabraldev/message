import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/model/user.dart';
import 'package:message/route/generating_route.dart';
import 'package:message/util/color.dart';

import '../widget/path.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //controllers
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String _messageError = '';

  _validateFields() {
    //Recuperando os valores dos campos
    String name = _controllerName.text;
    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    _displayMessageError(String msg) {
      setState(() {
        _messageError = msg;
      });
    }

    //verificando se o campo nome esta vazio
    if (name.isNotEmpty) {
      //verificando se o nome tem 3 ou menos caracteres
      if (name.length >= 3) {
        //Verificando se o campo email esta vazio e se esta com o @
        if (email.isNotEmpty && email.contains('@')) {
          //Verificando se o campo senha esta vazio
          if (password.isNotEmpty) {
            //Verificando se a senha digitada possui 8 caracteres
            if (password.length > 6) {
              _displayMessageError('');

              //instanciando classe User
              User user = User();
              user.name = name;
              user.email = email;
              user.password = password;
              _registerUser(user);
            } else {
              _displayMessageError('Sua senha deve ter mais de 6 digitos');
            }
          } else {
            _displayMessageError('Digite sua senha');
          }
        } else {
          _displayMessageError('Digite um e-mail válido');
        }
      } else {
        setState(() {
          _displayMessageError('Seu nome deve possuir mais de 3 letras');
        });
      }
    } else {
      setState(() {
        _displayMessageError('Digite seu nome');
      });
    }
  }

  _registerUser(User user) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    )
        .then((firebaseUser) {
      //Salvando dados do usuário
      Firestore db = Firestore.instance;
      db
          .collection('users')
          .document(firebaseUser.user.uid)
          .setData(user.toMap());

      Navigator.pushNamedAndRemoveUntil(
          context, GeneratingRoute.ROUTE_HOME, (_) => false);
    }).catchError((e) {
      print('Erro: ' + e.toString());
      setState(() {
        _messageError = 'Erro ao cadastrar usuário';
      });
    });
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
                padding: EdgeInsets.only(left: 40, top: 40, right: 15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'asset/image/people_register.png',
                            width: 250,
                          ),
                        ],
                      ),
                    )
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
                    controller: _controllerName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                      hintText: 'Usuário',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.person)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
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
                          ),
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                  TextField(
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                        hintText: 'Senha',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixIcon: Icon(Icons.lock)),
                    obscureText: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: RaisedButton(
                      child: Text(
                        'Cadastrar',
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
