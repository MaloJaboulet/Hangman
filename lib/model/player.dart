import 'package:flutter/cupertino.dart';
import 'package:hangman/controller/players.dart';

class Player extends ChangeNotifier {
  String name = "";
  int highScore = 0;

  Player(String name, int highScore) {
    this.name = name;
    this.highScore = highScore;
  }

  Player.second(this.name);

  increaseHighScore(int highScorePlayer) {
    if (this.highScore <= highScorePlayer) {
      this.highScore = highScorePlayer;
      Players.increaseHighscore(Players.getPlayer(name));
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
