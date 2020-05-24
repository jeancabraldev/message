import 'package:flutter/material.dart';
import '../util/color.dart';

class ListViewMessage extends StatelessWidget {
  final List<String> listMessage = [
    'Olá',
    'Tudo bem com vc?',
    'Claro que sim',
    'Voce estava linda hj',
    'Obrigada, assim me deixa com vergonha, eu sou muito timida',
    'pq?',
    'O que é lindo tem que ser falado',
    'e vc é linda',
    'Vamos sair hj?',
    'pra onde?',
    'podemos ir no cinema',
    'o que acha',
    'ótimo'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: listMessage.length,
        itemBuilder: (context, index) {

          double widthContainer = MediaQuery.of(context).size.width * 0.8;
          Alignment alignStandard = Alignment.centerRight;
          Color colorStandard = messageColorPrimary;

          BoxDecoration boxDecorationPrimary = BoxDecoration(
            color: colorStandard,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(0),
            ),
          );

          BoxDecoration boxDecorationSecondary = BoxDecoration(
            color: messageColorSecondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          );

          if (index % 2 == 0) {
            alignStandard = Alignment.centerLeft;
            colorStandard = messageColorSecondary;
          }

          return Align(
            alignment: alignStandard,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: Container(
                width: widthContainer,
                padding: EdgeInsets.all(12),
                decoration: index % 2 == 0
                    ? boxDecorationSecondary
                    :  boxDecorationPrimary,
                child: Text(
                  listMessage[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
    ;
  }
}
