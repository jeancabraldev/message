class Conversation {
  String _name;
  String _message;
  String _image;

  Conversation(this._name, this._message, this._image);

  String get name => _name;

  set name(String value) => _name = value;

  String get message => _message;

  set message(String value) => _message = value;

  String get image => _image;

  set image(String value) => _image = value;
}
