import 'package:flutter/material.dart';
import 'package:message/util/color.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: linearGradientDark,
        title: Text('Configurações'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //carregando
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.black38,
                    backgroundImage: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=c9707b0d-87f5-47fe-b887-fe3cae3ace53'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        print('Camera');
                      },
                      icon: Icon(
                        Icons.photo_camera,
                        size: 40,
                        color: linearGradientDark,
                      ),
                      label: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    FlatButton.icon(
                      onPressed: () {
                        print('Album');
                      },
                      icon: Icon(
                        Icons.photo,
                        size: 40,
                        color: linearGradientDark,
                      ),
                      label: Text(
                        'Galeria',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 50),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                      hintText: 'Vitória Silva',
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Salvar alteração',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  color: linearGradientClear,
                  padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
