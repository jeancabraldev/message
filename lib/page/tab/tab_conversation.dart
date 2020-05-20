import 'package:flutter/material.dart';
import 'package:message/model/conversation.dart';

class TabConversation extends StatefulWidget {
  @override
  _TabConversationState createState() => _TabConversationState();
}

class _TabConversationState extends State<TabConversation> {
  List<Conversation> listConversation = [
    Conversation('Vitória Silva', 'Olá tudo bem!',
        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil1.jpg?alt=media&token=c9707b0d-87f5-47fe-b887-fe3cae3ace53'),
    Conversation('Pedro Bassam', 'Como você esta?',
        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil2.jpg?alt=media&token=d7aab1ca-3bf0-4d4e-9539-56dd424a9155'),
    Conversation('Maria Betânia', 'Oi',
        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil3.jpg?alt=media&token=7b84333e-d343-4916-a8fc-2c87799492fb'),
    Conversation('Joaquim Fenix', 'Joker',
        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil4.jpg?alt=media&token=8461e8d9-3a74-4e0c-a381-ec8491eaf7e3'),
    Conversation('Jamilton Soares', 'Flutter',
        'https://firebasestorage.googleapis.com/v0/b/message-9fad0.appspot.com/o/profile%2Fperfil5.jpg?alt=media&token=0c9bcbed-924d-46df-89c1-a0ab9ae81c71')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listConversation.length,
      itemBuilder: (context, index) {
        Conversation conversation = listConversation[index];
        return ListTile(
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          leading: CircleAvatar(
            maxRadius: 30,
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
              conversation.image
            ),
          ),
          title: Text(
            conversation.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(
            conversation.message
          ),
        );
      },
    );
  }
}
