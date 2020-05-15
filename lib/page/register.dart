import 'package:flutter/material.dart';

import '../widget/path.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      Colors.deepOrange,
                      Colors.orange,
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
                      'Cadastro',
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
                  TextField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                        hintText: 'Nome',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                          hintText: 'E-mail',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                  ),
                  TextField(
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
                      color: Colors.deepOrange,
                      padding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {},
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
