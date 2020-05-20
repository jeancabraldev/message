import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/page/login.dart';
import 'package:message/page/tab/tab_contact.dart';
import 'package:message/page/tab/tab_conversation.dart';
import 'package:message/route/generating_route.dart';
import 'package:message/util/color.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controllerTab;
  String _emailUser = '';
  List<String> itemMenu = ['Configurações', 'Sair da conta'];

  //Recuperando dados do usuário logado
  Future _recoverUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogin = await auth.currentUser();
    setState(() {
      _emailUser = userLogin.email;
    });
  }

  @override
  void initState() {
    super.initState();
    _recoverUserData();
    _controllerTab = TabController(length: 2, vsync: this);
  }

  _itemMenu(String item) {
    switch (item) {
      case 'Configurações':
        Navigator.pushNamed(context, GeneratingRoute.ROUTE_CONFIG);
        break;
      case 'Sair da conta':
        _logout();
        break;
    }
  }

  _logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, GeneratingRoute.ROUTE_LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //automaticallyImplyLeading: false,
          backgroundColor: linearGradientDark,
          title: Text('App Message'),
          bottom: TabBar(
            indicatorWeight: 4,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            controller: _controllerTab,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(text: 'Conversas',),
              Tab(text: 'Contatos'),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: _itemMenu,
              itemBuilder: (context) {
                return itemMenu.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: TabBarView(
          controller: _controllerTab,
          children: <Widget>[
            TabConversation(),
            TabContact(),
          ],
        ));
  }
}
