import 'package:flutter/material.dart';
import 'package:message/util/color.dart';

class BoxMessage extends StatelessWidget {
  TextEditingController _controllerMessage = TextEditingController();

  _sendMessage() {}

  _sendPicture() {
    print('Abrindo camera');
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: TextField(
                controller: _controllerMessage,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Digite uma mensagem',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: linearGradientDark,
                    ),
                    onPressed: _sendPicture,
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: linearGradientDark,
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
            mini: true,
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
