import 'package:flutter/material.dart';
import 'package:message/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message/route/generating_route.dart';

class TabContact extends StatefulWidget {
  @override
  _TabContactState createState() => _TabContactState();
}

class _TabContactState extends State<TabContact> {
  String _idUserLogged;
  String _emailUserLoggerd;

  Future<List<User>> _recoverContact() async {
    Firestore db = Firestore.instance;
    QuerySnapshot querySnapshot = await db.collection('users').getDocuments();

    List<User> listContact = List();
    //Percorrendo a lista de usuários cadastrados
    for (DocumentSnapshot item in querySnapshot.documents) {
      var info = item.data;
      /*
      Verificandp se o usuário esta logado, caso esteja seus dados
      não serão exibidos na lista de contatos
      */
      if (info['email'] == _emailUserLoggerd) continue;
      User user = User();
      user.urlImage = info['urlImage'];
      user.name = info['name'];
      user.email = info['email'];
      listContact.add(user);
    }
    return listContact;
  }

  //Recuperando informações do usuário logado
  _recoverUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;
    _emailUserLoggerd = userLogged.email;
  }

  @override
  void initState() {
    super.initState();
    _recoverUserData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _recoverContact(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Container(
              padding: EdgeInsets.only(top: 200),
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    List<User> listItems = snapshot.data;
                    User user = listItems[index];

                    return ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, GeneratingRoute.ROUTE_MESSAGE,
                            arguments: user);
                      },
                      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundColor: Colors.black38,
                        backgroundImage: user.urlImage != null
                            ? NetworkImage(user.urlImage)
                            : null,
                      ),
                      title: Text(
                        user.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
            );
            break;
        }
        return null;
      },
    );
  }
}
