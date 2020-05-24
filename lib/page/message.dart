import 'package:flutter/material.dart';
import 'package:message/model/user.dart';
import '../widget/boxMessage.dart';
import '../widget/listViewMessage.dart';

class Message extends StatefulWidget {

  User contact;

  Message(this.contact);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  var boxMessage = Container();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                ListViewMessage(),
                BoxMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
