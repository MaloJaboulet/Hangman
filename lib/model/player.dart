import 'package:flutter/cupertino.dart';

class Player extends ChangeNotifier {
  String name = "";
  int highScore = 0;

  Player(String name, int highScore) {
    this.name = name;
    this.highScore;
  }

  /*Player({
    required this.name,
    required this.highScore,
  });*/

  Player.second(this.name);

  increaseHighScore(int highScore) {
    if (this.highScore < highScore) {
      this.highScore = highScore;
      notifyListeners();
    }
  }

  Map toJson() => {
        'name': name,
        'highScore': highScore,
      };

  factory Player.fromJson(dynamic json) {
    return Player(json['name'] as String, json['highScore'] as int);
  }
}
