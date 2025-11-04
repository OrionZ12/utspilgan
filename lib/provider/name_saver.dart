import 'package:flutter/foundation.dart';

class NameSaver extends ChangeNotifier {
  String _name = '';

  String get name => _name;

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }
}
