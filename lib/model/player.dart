import 'package:flutter/cupertino.dart';

class Player extends ChangeNotifier{

  String _name = "";
  int _highScore = 0;

  Player(this._name, this._highScore);

  Player.name(this._name);

  increaseHighScore(int highScore){
    if (_highScore <highScore){
      _highScore = highScore;
      notifyListeners();
    }
  }

  int get highScore => _highScore;

  set highScore(int value) {
    _highScore = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}