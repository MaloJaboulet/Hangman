import 'package:flutter/cupertino.dart';
import 'package:hangman/model/player.dart';

class Players extends ChangeNotifier{

  List<Player> _playersList = [];


  Players(this._playersList);

  addPlayer(String name, int highscore){
    _playersList.add(Player(name, highscore));
    notifyListeners();
  }

  List<Player> get getList => List.unmodifiable(_playersList);

  Player getPlayer(String name) {
    for(var player in _playersList){
      if (player.name == name){
        return player;
      }
    }
    return Player("no player", 0);
  }

}