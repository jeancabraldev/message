import 'package:flutter/material.dart';
import 'package:message/util/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  TextEditingController _controllerName = TextEditingController();
  File _image;
  String _idUserLogged;
  bool _upImage = false;
  String _recoveredUrlImage;

  /*
  Escolhendo um foto para o perfil do usuário utilizandp a galeria de imagens
  ou a camera
  */
  Future _recoverImage(String sourceImage) async {
    File selectedImage;
    switch (sourceImage) {
      case 'camera':
        selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case 'galeria':
        selectedImage =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _image = selectedImage;
      //verificando se a imagem foi capturada
      if (_image != null) {
        _upImage = true;
        _uploadImage();
      }
    });
  }

  Future _uploadImage() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference folderRoot = storage.ref();
    StorageReference archive =
        folderRoot.child('profile').child(_idUserLogged + '.jpg');

    //upload image
    StorageUploadTask task = archive.putFile(_image);

    //Controlando o progresso do upload da imagem
    task.events.listen((StorageTaskEvent storageTaskEvent) {
      if (storageTaskEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _upImage = true;
        });
      } else if (storageTaskEvent.type == StorageTaskEventType.success) {
        setState(() {
          _upImage = false;
        });
      }
    });

    //Recuperando URL da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recoverUrlImage(snapshot);
    });
  }

  Future _recoverUrlImage(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    _updateUrlImage(url);
    setState(() {
      _recoveredUrlImage = url;
    });
  }

  _updateUrlImage(String url) {
    Firestore db = Firestore.instance;

    Map<String, dynamic> updateImageUrl = {'urlImage': url};

    db.collection('users').document(_idUserLogged).updateData(updateImageUrl);
  }

  _updateName() {
    String name = _controllerName.text;
    Firestore db = Firestore.instance;
    Map<String, dynamic> updateName = {'name': name};
    db.collection('users').document(_idUserLogged).updateData(updateName);
  }

  //Recuperando dados do usuário
  _recoverUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;

    //Recuperando nome do usuário
    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection('users').document(_idUserLogged).get();

    Map<String, dynamic> recoveredData = snapshot.data;
    _controllerName.text = recoveredData['name'];

    //Verificando se a url da imagem existe
    if (recoveredData['urlImage'] != null) {
      setState(() {
        _recoveredUrlImage = recoveredData['urlImage'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recoverUserData();
  }

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
                    backgroundColor: Colors.black26,
                    backgroundImage: _recoveredUrlImage != null
                        ? NetworkImage(_recoveredUrlImage)
                        : null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                      onPressed: () {
                        _recoverImage('camera');
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
                        _recoverImage('galeria');
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
                    controller: _controllerName,
                    /*onChanged: (texto){
                      _updateName(texto);
                    },*/
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(30, 14, 30, 14),
                      hintText: '',
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Salvar alterações',
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
                    _updateName();
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: _upImage ? CircularProgressIndicator() : Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
